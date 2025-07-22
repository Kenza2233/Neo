import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';

class CloudService {
  // Singleton pattern
  static final CloudService _instance = CloudService._internal();
  factory CloudService() => _instance;
  CloudService._internal();

  GoogleSignInAccount? _googleUser;
  AuthorizationCredentialAppleID? _appleUser;

  bool get isGoogleSignedIn => _googleUser != null;
  bool get isAppleSignedIn => _appleUser != null;

  Future<bool> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: [drive.DriveApi.driveAppdataScope],
    );
    try {
      _googleUser = await googleSignIn.signIn();
      return isGoogleSignedIn;
    } catch (error) {
      print("Google Sign-In Error: $error");
      return false;
    }
  }

  Future<void> signOutFromGoogle() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    _googleUser = null;
  }

  Future<bool> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      _appleUser = credential;
      return isAppleSignedIn;
    } catch (error) {
      print("Apple Sign-In Error: $error");
      return false;
    }
  }

  Future<http.Client?> getGoogleHttpClient() async {
    if (!isGoogleSignedIn) return null;
    final authHeaders = await _googleUser!.authHeaders;
    final client = authenticatedClient(
        http.Client(),
        AccessCredentials(
          AccessToken(
            'Bearer',
            authHeaders['Authorization']!.substring(7), // Remove 'Bearer '
            DateTime.now().toUtc().add(const Duration(hours: 1)),
          ),
          null, // No refresh token
          ['https://www.googleapis.com/auth/drive.appdata'],
        ));
    return client;
  }

  // --- Google Drive Sync ---
  Future<void> uploadToGoogleDrive(String content) async {
    final client = await getGoogleHttpClient();
    if (client == null) throw Exception('Not signed in to Google');

    final driveApi = drive.DriveApi(client);
    final file = drive.File()
      ..name = 'nite_backup.json'
      ..parents = ['appDataFolder'];

    final media = http.ByteStream(Stream.value(utf8.encode(content)));
    final mediaLength = utf8.encode(content).length;

    await driveApi.files.create(file, uploadMedia: drive.Media(media, mediaLength));
  }

  Future<String?> downloadFromGoogleDrive() async {
    final client = await getGoogleHttpClient();
    if (client == null) throw Exception('Not signed in to Google');

    final driveApi = drive.DriveApi(client);
    final fileList = await driveApi.files.list(spaces: 'appDataFolder');
    final files = fileList.files;
    if (files == null || files.isEmpty) return null;

    final fileId = files.first.id!;
    final media = await driveApi.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

    final content = await utf8.decodeStream(media.stream);
    return content;
  }
}
