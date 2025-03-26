import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Résumer'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Text('Summary screen'),
      bottomNavigationBar: const BottomNavBar(qrData: ''),
    );
    throw UnimplementedError();
    }
  }
