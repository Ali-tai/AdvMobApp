import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class MacrosScreen extends StatelessWidget {
  const MacrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Macros')),
      body: const Center(
        child: Text('Macros Details Here', style: TextStyle(fontSize: 18)),
      ),
      bottomNavigationBar: const BottomNavBar(qrData: ''),
    );
  }
}
