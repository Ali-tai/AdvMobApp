import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // <-- Ajouté
import '../widgets/battery_indicator.dart';
import '../providers/user_preferences.dart';

class MacrosScreen extends StatelessWidget {
  const MacrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // <-- Ajouté pour récupérer les traductions
    final userPrefs = Provider.of<UserPreferences>(context);

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      appBar: AppBar(
        title: Text(localizations.energy, style: TextStyle(color: userPrefs.textColor, fontSize: 24)),
        backgroundColor: userPrefs.appBarColor,
        centerTitle: true,
      ),
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
                      _macroColumn(localizations.energy, userPrefs.energy, userPrefs.maxEnergy, userPrefs.textColor),
                      const SizedBox(width: 35),
                      _macroColumn(localizations.carbs, userPrefs.carbs, userPrefs.maxCarbs, userPrefs.textColor),
                      const SizedBox(width: 35),
                      _macroColumn(localizations.fats, userPrefs.fats, userPrefs.maxFats, userPrefs.textColor),
                    ],
                  ),

                  const SizedBox(height: 100),

                  /// 🔋 Deuxième rangée : Fibres, Protéines, Sel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _macroColumn(localizations.fiber, userPrefs.fiber, userPrefs.maxFiber, userPrefs.textColor), // <-- Traduction ici
                      const SizedBox(width: 35),
                      _macroColumn(localizations.proteins, userPrefs.protein, userPrefs.maxProtein, userPrefs.textColor), // <-- Traduction ici
                      const SizedBox(width: 35),
                      _macroColumn(localizations.salt, userPrefs.salt, userPrefs.maxSalt, userPrefs.textColor), // <-- Traduction ici
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
  Widget _macroColumn(String label, int level, int max, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 20)),
        Text(max.toString(), style: TextStyle(color: color, fontSize: 20)),
        BatteryIndicator(level: (level / max).toDouble(), bordercolor: color),
        Text(level.toString(), style: TextStyle(color: color, fontSize: 20)),
      ],
    );
  }
}
