import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutri_tracker/screens/scan_screen.dart';
import 'package:nutri_tracker/screens/info_screen.dart';
import 'package:nutri_tracker/screens/summary_screen.dart';
import 'package:provider/provider.dart';
import 'package:nutri_tracker/providers/user_preferences.dart';

class MainScreenWithNavigation extends StatefulWidget {
  const MainScreenWithNavigation({super.key});

  @override
  _MainScreenWithNavigationState createState() => _MainScreenWithNavigationState();
}

class _MainScreenWithNavigationState extends State<MainScreenWithNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final userPrefs = Provider.of<UserPreferences>(context);
    final List<Widget> _screens = [
      const ScanScreen(),
      const InfoScreen(productData: {}),
      const SummaryScreen(),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: userPrefs.appBarColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt, color: userPrefs.backgroundColor), label: localizations.scanQRTitle, backgroundColor: userPrefs.backgroundColor),
          BottomNavigationBarItem(icon: Icon(Icons.info, color: userPrefs.backgroundColor), label: localizations.product, backgroundColor: userPrefs.backgroundColor),
          BottomNavigationBarItem(icon: Icon(Icons.summarize, color: userPrefs.backgroundColor), label: localizations.summaryTitle, backgroundColor: userPrefs.backgroundColor),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: userPrefs.backgroundColor,
        unselectedItemColor: userPrefs.textColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
