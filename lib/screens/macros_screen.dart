import 'package:flutter/material.dart';
import '../widgets/battery_indicator.dart';
import '../widgets/bottom_nav_bar.dart';

class MacrosScreen extends StatelessWidget {
  const MacrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Macros'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Column(
                  children: [
                    Text("Energie", style: TextStyle(fontSize: 20)),
                    BatteryIndicator(level: 0.3),
                  ],
                ),
                SizedBox(width: 60),
                Column(
                  children: [
                    Text("Glucides", style: TextStyle(fontSize: 20)),
                    BatteryIndicator(level: 0.6),
                  ],
                ),
                SizedBox(width: 60),
                Column(
                  children: [
                    Text("Lipides", style: TextStyle(fontSize: 20)),
                    BatteryIndicator(level: 1.0),
                  ],
                ),
              ],
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Column(
                  children: [
                    Text("Fibres", style: TextStyle(fontSize: 20)),
                    BatteryIndicator(level: 0.4),
                  ],
                ),
                SizedBox(width: 60),
                Column(
                  children: [
                    Text("Protéines", style: TextStyle(fontSize: 20)),
                    BatteryIndicator(level: 0.6),
                  ],
                ),
                SizedBox(width: 60),
                Column(
                  children: [
                    Text("Sel", style: TextStyle(fontSize: 20)),
                    BatteryIndicator(level: 0.1),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(qrData: ''),
    );
  }
}
