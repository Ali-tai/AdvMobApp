import 'package:flutter/material.dart';
import 'package:nutri_tracker/screens/scan_screen.dart';
import 'package:nutri_tracker/screens/info_screen.dart';
import 'package:nutri_tracker/screens/summary_screen.dart';

class MainScreenWithNavigation extends StatefulWidget {
  const MainScreenWithNavigation({super.key});

  @override
  _MainScreenWithNavigationState createState() => _MainScreenWithNavigationState();
}

class _MainScreenWithNavigationState extends State<MainScreenWithNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final List<Widget> _screens = [
      const ScanScreen(),
      const InfoScreen(productData: {}),
      const SummaryScreen(),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.summarize), label: 'Résumé'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}