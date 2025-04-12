import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutri_tracker/screens/macros_screen.dart';
import 'package:nutri_tracker/screens/personal_info_screen.dart';
import 'package:nutri_tracker/screens/allergies_screen.dart';
import 'package:nutri_tracker/providers/user_preferences.dart';
import '../widgets/battery_indicator.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  late TextEditingController _allergiesController;

  @override
  void initState() {
    super.initState();
    final userPrefs = Provider.of<UserPreferences>(context, listen: false);
    _updateAllergiesText(userPrefs.allergies);
  }

  void _updateAllergiesText(List<String> allergies) {
    _allergiesController = TextEditingController(
      text: allergies.isNotEmpty ? "Allergies : ${allergies.join(', ')}" : "Allergies : Aucune",
    );
  }

  @override
  void dispose() {
    _allergiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Résumé'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔋 **Indicateurs de macros**
            Consumer<UserPreferences>(
              builder: (context, userPrefs, child) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MacrosScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BatteryIndicator(level: userPrefs.energy / userPrefs.maxEnergy),
                      const SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.carbs / userPrefs.maxCarbs),
                      const SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.fats / userPrefs.maxFats),
                      const SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.fiber / userPrefs.maxFiber),
                      const SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.protein / userPrefs.maxProtein),
                      const SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.salt / userPrefs.maxSalt),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            /// 📏 **Poids / Taille / Sexe**
            Consumer<UserPreferences>(
              builder: (context, userPrefs, child) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInfoScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: Column(
                    children: [
                      Text("Poids :   ${userPrefs.weight} Kg", style: const TextStyle(fontSize: 22)),
                      const SizedBox(height: 10),
                      Text("Taille :  ${userPrefs.height} cm", style: const TextStyle(fontSize: 22)),
                      const SizedBox(height: 10),
                      Text("Age :  ${userPrefs.age} ans", style: const TextStyle(fontSize: 22)),
                      const SizedBox(height: 10),
                      Text("Sexe :  ${userPrefs.gender}", style: const TextStyle(fontSize: 22)),
                      const SizedBox(height: 10),
                      Text("Activité : ${userPrefs.activityLevel.toStringAsFixed(1)}", style: const TextStyle(fontSize: 22)),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            /// ⚠️ **Allergies**
            Consumer<UserPreferences>(
              builder: (context, userPrefs, child) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllergiesScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Allergies :", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          userPrefs.allergies.isNotEmpty ? userPrefs.allergies.join(', ') : "Aucune",
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
