import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutri_tracker/widgets/macro_column.dart';
import 'package:nutri_tracker/providers/user_preferences.dart';

class MacrosScreen extends StatelessWidget {
  const MacrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
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
                  /// Première rangée : Énergie, Glucides, Lipides
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MacroColumn(label : localizations.energy, level: userPrefs.energy, max: userPrefs.maxEnergy, color: userPrefs.textColor),
                      const SizedBox(width: 35),
                      MacroColumn(label : localizations.carbs, level: userPrefs.carbs, max: userPrefs.maxCarbs, color: userPrefs.textColor),
                      const SizedBox(width: 35),
                      MacroColumn(label : localizations.fats, level: userPrefs.fats, max: userPrefs.maxFats, color: userPrefs.textColor),
                    ],
                  ),

                  const SizedBox(height: 100),

                  /// Deuxième rangée : Fibres, Protéines, Sel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MacroColumn(label : localizations.fiber, level: userPrefs.fiber, max: userPrefs.maxFiber, color: userPrefs.textColor),
                      const SizedBox(width: 35),
                      MacroColumn(label : localizations.proteins, level: userPrefs.protein, max: userPrefs.maxProtein, color: userPrefs.textColor),
                      const SizedBox(width: 35),
                      MacroColumn(label : localizations.salt, level: userPrefs.salt, max: userPrefs.maxSalt, color: userPrefs.textColor),
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
}
