import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutri_tracker/screens/Home/Summary/macros_screen.dart';
import 'package:nutri_tracker/screens/Home/Summary/personal_info_screen.dart';
import 'package:nutri_tracker/screens/Home/Summary/allergies_screen.dart';
import 'package:nutri_tracker/providers/user_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/macro_column.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final userPrefs = Provider.of<UserPreferences>(context);

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      appBar: AppBar(
        title: Text(localizations.summaryTitle,
            style: TextStyle(color: userPrefs.textColor, fontSize: 24)
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: userPrefs.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            /// Indicateurs de macros
            Consumer<UserPreferences>(
              builder: (context, userPrefs, child) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MacrosScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: userPrefs.backgroundColor,
                    padding: EdgeInsets.symmetric(vertical: 40),
                    side: BorderSide(color: userPrefs.textColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BatteryIndicator(level: userPrefs.energy / userPrefs.maxEnergy, bordercolor: userPrefs.textColor),
                      SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.carbs / userPrefs.maxCarbs, bordercolor: userPrefs.textColor),
                      SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.fats / userPrefs.maxFats, bordercolor: userPrefs.textColor),
                      SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.fiber / userPrefs.maxFiber, bordercolor: userPrefs.textColor),
                      SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.protein / userPrefs.maxProtein, bordercolor: userPrefs.textColor),
                      SizedBox(width: 8),
                      BatteryIndicator(level: userPrefs.salt / userPrefs.maxSalt, bordercolor: userPrefs.textColor),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 10),

            /// Poids / Taille / Sexe
            Consumer<UserPreferences>(
              builder: (context, userPrefs, child) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: userPrefs.backgroundColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                    side: BorderSide(color: userPrefs.textColor),
                  ),
                  child: Column(
                    children: [
                      Text("${localizations.weight} ${userPrefs.weight} ${localizations.kg}", style: TextStyle(color: userPrefs.textColor, fontSize: 22)),
                      SizedBox(height: 10),
                      Text("${localizations.height} ${userPrefs.height} ${localizations.cm}", style: TextStyle(color: userPrefs.textColor, fontSize: 22)),
                      SizedBox(height: 10),
                      Text("${localizations.age} ${userPrefs.age} ${localizations.ans}", style: TextStyle(color: userPrefs.textColor, fontSize: 22)),
                      SizedBox(height: 10),
                      Text("${localizations.gender} ${userPrefs.gender == "homme" ? localizations.male : localizations.female}", style: TextStyle(color: userPrefs.textColor, fontSize: 22)),
                      SizedBox(height: 10),
                      Text("${localizations.activity} ${userPrefs.activityLevel.toStringAsFixed(1)}", style: TextStyle(color: userPrefs.textColor, fontSize: 22)),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 10),

            /// Allergies
            Consumer<UserPreferences>(
              builder: (context, userPrefs, child) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllergiesScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    backgroundColor: userPrefs.backgroundColor,
                    side: BorderSide(color: userPrefs.textColor),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(localizations.allergies, style: TextStyle(color: userPrefs.textColor, fontSize: 22, fontWeight: FontWeight.bold)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: Text(
                          userPrefs.getAllergiesText(localizations).join(', '),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: userPrefs.textColor, fontSize: 20),
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
