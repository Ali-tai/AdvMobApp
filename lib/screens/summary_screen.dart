import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutri_tracker/screens/macros_screen.dart';
import 'package:nutri_tracker/screens/personal_info_screen.dart';
import 'package:nutri_tracker/screens/allergies_screen.dart';
import 'package:nutri_tracker/providers/user_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/battery_indicator.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  // No need for a TextEditingController here as we are just displaying text.

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
            /// 🔋 **Indicateurs de macros**
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

            /// 📏 **Poids / Taille / Sexe**
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

            /// ⚠️ **Allergies**
            Consumer<UserPreferences>(
              builder: (context, userPrefs, child) {
                // Get the current locale's translations
                final currentLocalizations = AppLocalizations.of(context)!;

                // Translate the allergy keys to the current locale
                List<String> translatedAllergies = userPrefs.allergies.map((key) => _getAllergyLabel(currentLocalizations, key)).toList();

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
                          translatedAllergies.isNotEmpty ? translatedAllergies.join(', ') : localizations.noAllergies,
                          textAlign: TextAlign.left,
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

  // Helper function to get the translated allergy label based on the key
  String _getAllergyLabel(AppLocalizations localizations, String allergyKey) {
    switch (allergyKey) {
      case 'allergy_arachides': return localizations.allergy_arachides;
      case 'allergy_amandes': return localizations.allergy_amandes;
      case 'allergy_noix': return localizations.allergy_noix;
      case 'allergy_noisettes': return localizations.allergy_noisettes;
      case 'allergy_noix_de_cajou': return localizations.allergy_noix_de_cajou;
      case 'allergy_pistaches': return localizations.allergy_pistaches;
      case 'allergy_noix_de_pecan': return localizations.allergy_noix_de_pecan;
      case 'allergy_noix_du_bresil': return localizations.allergy_noix_du_bresil;
      case 'allergy_noix_de_macadamia': return localizations.allergy_noix_de_macadamia;
      case 'allergy_lait': return localizations.allergy_lait;
      case 'allergy_oeufs': return localizations.allergy_oeufs;
      case 'allergy_soja': return localizations.allergy_soja;
      case 'allergy_ble': return localizations.allergy_ble;
      case 'allergy_poisson': return localizations.allergy_poisson;
      case 'allergy_crevettes': return localizations.allergy_crevettes;
      case 'allergy_crabes': return localizations.allergy_crabes;
      case 'allergy_homards': return localizations.allergy_homards;
      case 'allergy_moules': return localizations.allergy_moules;
      case 'allergy_huitres': return localizations.allergy_huitres;
      case 'allergy_palourdes': return localizations.allergy_palourdes;
      case 'allergy_sesame': return localizations.allergy_sesame;
      case 'allergy_moutarde': return localizations.allergy_moutarde;
      case 'allergy_celeri': return localizations.allergy_celeri;
      case 'allergy_lupin': return localizations.allergy_lupin;
      case 'allergy_mais': return localizations.allergy_mais;
      case 'allergy_riz': return localizations.allergy_riz;
      case 'allergy_avoine': return localizations.allergy_avoine;
      case 'allergy_orge': return localizations.allergy_orge;
      case 'allergy_seigle': return localizations.allergy_seigle;
      case 'allergy_graines_de_tournesol': return localizations.allergy_graines_de_tournesol;
      case 'allergy_graines_de_citrouille': return localizations.allergy_graines_de_citrouille;
      case 'allergy_graines_de_pavot': return localizations.allergy_graines_de_pavot;
      case 'allergy_cannelle': return localizations.allergy_cannelle;
      case 'allergy_clou_de_girofle': return localizations.allergy_clou_de_girofle;
      case 'allergy_levure': return localizations.allergy_levure;
      case 'allergy_glutamate_monosodique': return localizations.allergy_glutamate_monosodique;
      case 'allergy_sulfites': return localizations.allergy_sulfites;
      case 'allergy_tartrazine': return localizations.allergy_tartrazine;
      case 'allergy_benzoates': return localizations.allergy_benzoates;
      case 'allergy_sorbates': return localizations.allergy_sorbates;
      case 'allergy_avocat': return localizations.allergy_avocat;
      case 'allergy_banane': return localizations.allergy_banane;
      case 'allergy_kiwi': return localizations.allergy_kiwi;
      case 'allergy_mangue': return localizations.allergy_mangue;
      case 'allergy_noix_de_coco': return localizations.allergy_noix_de_coco;
      case 'allergy_huile_de_sesame': return localizations.allergy_huile_de_sesame;
      case 'allergy_huile_d_arachide': return localizations.allergy_huile_d_arachide;
      default: return allergyKey;
    }
  }
}