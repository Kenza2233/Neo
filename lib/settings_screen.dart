import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _uiAnimationsEnabled = true;

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
          _buildCategoryHeader('Tentang'),
          ListTile(
            title: const Text('Versi Aplikasi'),
            subtitle: const Text('1.0.0 (Alpha)'), // Contoh
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSetting(String label, String key, String defaultValue) {
    final controller = TextEditingController();
    // In a real app, you would load the initial value from SharedPreferences
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
          // In a real app, you would save this value to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          // This is a simplified save, you'd likely want a "Save" button
          // and parse the value to the correct type (int/double).
          await prefs.setString(key, value);
        },
      ),
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
