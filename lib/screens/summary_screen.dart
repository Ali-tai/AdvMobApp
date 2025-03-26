import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      body: const Center(
        child: Text('Summary Details Here', style: TextStyle(fontSize: 18)),
      ),
      bottomNavigationBar: const BottomNavBar(qrData: ''),
    );
  }
}
