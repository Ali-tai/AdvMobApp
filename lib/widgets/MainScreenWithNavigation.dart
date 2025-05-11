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
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt, color: _selectedIndex == 0 ? userPrefs.textColor : userPrefs.iconColor), label: localizations.scanQRTitle, backgroundColor: userPrefs.iconColor),
          BottomNavigationBarItem(icon: Icon(Icons.info, color: _selectedIndex == 1 ? userPrefs.textColor : userPrefs.iconColor), label: localizations.product, backgroundColor: userPrefs.iconColor),
          BottomNavigationBarItem(icon: Icon(Icons.summarize, color: _selectedIndex == 2 ? userPrefs.textColor : userPrefs.iconColor), label: localizations.summaryTitle, backgroundColor: userPrefs.iconColor),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: userPrefs.textColor,
        unselectedItemColor: userPrefs.iconColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
