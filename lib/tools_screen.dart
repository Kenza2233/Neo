import 'package:flutter/material.dart';
import 'conversion_service.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  _ToolsScreenState createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  final _conversionService = ConversionService();
  final _textController = TextEditingController();
  String _output = '';

  // State for base conversion
  int _fromBase = 10;
  int _toBase = 2;

  void _performConversion(Function(String) conversionFunc) {
    setState(() {
      _output = conversionFunc(_textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alat Utilitas'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Input',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            Text('Output:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(_output),
              height: 150,
            ),
            const Divider(height: 32),

            // --- Number Base Conversion ---
            Text('Konversi Basis Bilangan', style: Theme.of(context).textTheme.titleLarge),
            // (UI for selecting from/to base would go here)
            Wrap(
              spacing: 8.0,
              children: [
                ElevatedButton(onPressed: () => setState(() => _output = _conversionService.convertBase(_textController.text, 10, 2) ?? 'Input tidak valid'), child: const Text('Desimal ke Biner')),
                ElevatedButton(onPressed: () => setState(() => _output = _conversionService.convertBase(_textController.text, 16, 10) ?? 'Input tidak valid'), child: const Text('Hex ke Desimal')),
              ],
            ),

            const Divider(height: 32),

            // --- Character Encoding ---
            Text('Pengkodean Karakter', style: Theme.of(context).textTheme.titleLarge),
            Wrap(
              spacing: 8.0,
              children: [
                ElevatedButton(onPressed: () => _performConversion(_conversionService.textToAscii), child: const Text('Teks -> ASCII')),
                ElevatedButton(onPressed: () => _performConversion(_conversionService.asciiToText), child: const Text('ASCII -> Teks')),
                ElevatedButton(onPressed: () => _performConversion(_conversionService.textToUnicode), child: const Text('Teks -> Unicode')),
                ElevatedButton(onPressed: () => _performConversion(_conversionService.unicodeToText), child: const Text('Unicode -> Teks')),
              ],
            ),

            const Divider(height: 32),

            // --- Encryption ---
            Text('Enkripsi/Dekripsi (AES)', style: Theme.of(context).textTheme.titleLarge),
             Wrap(
              spacing: 8.0,
              children: [
                ElevatedButton(onPressed: () => _performConversion(_conversionService.encryptAES), child: const Text('Enkripsi')),
                ElevatedButton(onPressed: () => _performConversion(_conversionService.decryptAES), child: const Text('Dekripsi')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
