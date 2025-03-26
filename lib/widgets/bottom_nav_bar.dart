import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/scan_screen.dart';
import '../screens/info_screen.dart';

class BottomNavBar extends StatelessWidget {
  final String qrData;

  const BottomNavBar({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Scan'),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoScreen(qrData: qrData),
            ),
          );
        }
      },
    );
  }
}
