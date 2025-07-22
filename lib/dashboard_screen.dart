import 'package:flutter/material.dart';
import 'note_model.dart';

class DashboardScreen extends StatelessWidget {
  final Note note;

  const DashboardScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dasbor Catatan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.purple.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80), // For app bar spacing
              Text(
                'Analitik untuk Catatan:',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                note.content.isEmpty ? '"Catatan Kosong"' : '"${note.content.substring(0, (note.content.length > 50) ? 50 : note.content.length)}..."',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildStatCard(
                      context: context,
                      icon: Icons.timer,
                      label: 'Durasi Mengetik',
                      value: '${note.typingDuration} detik',
                      gradient: LinearGradient(colors: [Colors.orange.shade400, Colors.orange.shade800]),
                    ),
                    _buildStatCard(
                      context: context,
                      icon: Icons.calculate,
                      label: 'Jumlah Kata',
                      value: note.wordCount.toString(),
                      gradient: LinearGradient(colors: [Colors.green.shade400, Colors.green.shade800]),
                    ),
                    _buildStatCard(
                      context: context,
                      icon: Icons.open_in_new,
                      label: 'Jumlah Dibuka',
                      value: note.openCount.toString(),
                      gradient: LinearGradient(colors: [Colors.pink.shade400, Colors.pink.shade800]),
                    ),
                    _buildStatCard(
                      context: context,
                      icon: Icons.delete_sweep,
                      label: 'Jumlah Hapus',
                      value: note.deleteCount.toString(),
                      gradient: LinearGradient(colors: [Colors.red.shade400, Colors.red.shade800]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required Gradient gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
