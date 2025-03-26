import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NutriTrack')),
      body: const Center(
        child: Text('Welcome to NutriTrack', style: TextStyle(fontSize: 18)),
      ),
      bottomNavigationBar: const BottomNavBar(qrData: ''),
    );
  }
}
