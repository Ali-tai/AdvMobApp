import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/info_screen.dart'; // Make sure this is imported
import 'screens/summary_screen.dart';
import 'screens/macros_screen.dart';
import 'screens/personal_info_screen.dart';
import 'screens/allergies_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  runApp(const NutriTrackApp());
}

class NutriTrackApp extends StatelessWidget {
  const NutriTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriTrack',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MainScreenWithNavigation(),
    );
  }
}

class MainScreenWithNavigation extends StatefulWidget {
  const MainScreenWithNavigation({super.key});

  @override
  _MainScreenWithNavigationState createState() => _MainScreenWithNavigationState();
}

class _MainScreenWithNavigationState extends State<MainScreenWithNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ScanScreen(),
    const InfoScreen(qrData: "Placeholder QR Data"), // Added qrData
    const SummaryScreen(),
    const MacrosScreen(),
    const PersonalInfoScreen(),
    const AllergiesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.summarize), label: 'Summary'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Macros'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Personal'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Allergies'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}