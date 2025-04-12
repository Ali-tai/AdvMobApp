import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/battery_indicator.dart';
import '../providers/user_preferences.dart';

class MacrosScreen extends StatelessWidget {
  const MacrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Macros'), centerTitle: true),
      body: Consumer<UserPreferences>(
        builder: (context, userPrefs, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// 🔋 Première rangée : Énergie, Glucides, Lipides
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _macroColumn("Énergie", userPrefs.energy, userPrefs.maxEnergy),
                      const SizedBox(width: 35),
                      _macroColumn("Glucides", userPrefs.carbs, userPrefs.maxCarbs),
                      const SizedBox(width: 35),
                      _macroColumn("Lipides", userPrefs.fats, userPrefs.maxFats),
                    ],
                  ),

                  const SizedBox(height: 100),

                  /// 🔋 Deuxième rangée : Fibres, Protéines, Sel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _macroColumn("Fibres", userPrefs.fiber, userPrefs.maxFiber),
                      const SizedBox(width: 35),
                      _macroColumn("Protéines", userPrefs.protein, userPrefs.maxProtein),
                      const SizedBox(width: 35),
                      _macroColumn("Sel", userPrefs.salt, userPrefs.maxSalt),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Widget helper
  Widget _macroColumn(String label, int level, int max) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 20)),
        Text(max.toString()),
        BatteryIndicator(level: (level / max).toDouble()),
        Text(level.toString()),
      ],
    );
  }
}
