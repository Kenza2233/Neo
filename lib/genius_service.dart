import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GeniusService {
  final String _baseUrl = 'https://api.genius.com';

  Future<String?> _getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('geniusApiKey');
  }

  Future<List<dynamic>> search(String query) async {
    final apiKey = await _getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Kunci API Genius tidak diatur.');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/search?q=${Uri.encodeComponent(query)}'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response']['hits'];
    } else {
      throw Exception('Gagal mencari lagu: ${response.body}');
    }
  }
}
