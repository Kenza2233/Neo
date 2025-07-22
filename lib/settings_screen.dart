import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'cloud_service.dart';
import 'note_model.dart';
import 'dart:convert';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _uiAnimationsEnabled = true;
  final CloudService _cloudService = CloudService();
  bool _isSigningIn = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _uiAnimationsEnabled = prefs.getBool('uiAnimationsEnabled') ?? true;
    });
  }

  void _setUiAnimations(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('uiAnimationsEnabled', value);
    setState(() {
      _uiAnimationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        children: [
          _buildCategoryHeader('Tampilan'),
          SwitchListTile(
            title: const Text('Mode Gelap'),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          ListTile(
            title: const Text('Bahasa Aplikasi'),
            subtitle: const Text('Indonesia (Konseptual)'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Font Aplikasi'),
            subtitle: const Text('Default (Konseptual)'),
            onTap: () {},
          ),
          SwitchListTile(
            title: const Text('Animasi UI'),
            value: _uiAnimationsEnabled,
            onChanged: _setUiAnimations,
          ),
          _buildCategoryHeader('Editor'),
          _buildTextFieldSetting('Batas Kata untuk Istirahat', 'restWordLimit', '100'),
          _buildTextFieldSetting('Ukuran Judul Default', 'defaultTitleSize', '24.0'),
          _buildTextFieldSetting('Ukuran Teks Default', 'defaultTextSize', '16.0'),
          _buildTextFieldSetting('Spasi Baris', 'lineSpacing', '1.5'),
          _buildTextFieldSetting('Spasi Huruf', 'letterSpacing', '0.5'),
          _buildCategoryHeader('Pencadangan & Sinkronisasi'),
          _buildCloudSection(),
          _buildCategoryHeader('Integrasi'),
          _buildTextFieldSetting('Kunci API Genius', 'geniusApiKey', ''),
          _buildCategoryHeader('Tentang'),
          ListTile(
            title: const Text('Versi Aplikasi'),
            subtitle: const Text('1.0.0 (Alpha)'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSetting(String label, String key, String defaultValue) {
    final controller = TextEditingController();
    controller.text = defaultValue;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
        ),
        onChanged: (value) async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(key, value);
        },
      ),
    );
  }

  Widget _buildCloudSection() {
    return _isSigningIn
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              if (!_cloudService.isGoogleSignedIn)
                ListTile(
                  title: const Text('Masuk dengan Google'),
                  onTap: () async {
                    setState(() => _isSigningIn = true);
                    await _cloudService.signInWithGoogle();
                    setState(() => _isSigningIn = false);
                  },
                ),
              if (_cloudService.isGoogleSignedIn) ...[
                ListTile(
                  title: const Text('Cadangkan ke Google Drive'),
                  onTap: () async {
                    final dummyNotes = [Note(id: '1', content: 'Test')];
                    final content = jsonEncode(dummyNotes.map((n) => n.toMap()).toList());
                    await _cloudService.uploadToGoogleDrive(content);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pencadangan selesai.')));
                  },
                ),
                ListTile(
                  title: const Text('Pulihkan dari Google Drive'),
                  onTap: () async {
                    final content = await _cloudService.downloadFromGoogleDrive();
                    if (content != null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pemulihan berhasil.')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak ada cadangan yang ditemukan.')));
                    }
                  },
                ),
                ListTile(
                  title: const Text('Keluar dari Google'),
                  onTap: () async {
                    await _cloudService.signOutFromGoogle();
                    setState(() {});
                  },
                ),
              ],
            ],
          );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
