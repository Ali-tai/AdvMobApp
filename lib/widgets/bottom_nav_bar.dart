import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/scan_screen.dart';
import '../screens/info_screen.dart';
import '../screens/summary_screen.dart';

class BottomNavBar extends StatelessWidget {
  final String qrData;

  const BottomNavBar({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan'),
        BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: 'Mesure'),
        BottomNavigationBarItem(icon: Icon(Icons.query_stats), label: 'Info'),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanScreen()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoScreen(productData: {})));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SummaryScreen()));
        }
      },
    );
  }
}
