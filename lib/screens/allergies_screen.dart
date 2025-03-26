import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class AllergiesScreen extends StatelessWidget {
  const AllergiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Allergies')),
      body: const Center(
        child: Text('User Allergies Details', style: TextStyle(fontSize: 18)),
      ),
      bottomNavigationBar: const BottomNavBar(qrData: ''),
    );
  }
}
