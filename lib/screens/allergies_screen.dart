import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/user_preferences.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  _AllergiesScreenState createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {
  final List<String> _possibleAllergiesKeys = const [
    'allergy_arachides',
    'allergy_amandes',
    'allergy_noix',
    'allergy_noisettes',
    'allergy_noix_de_cajou',
    'allergy_pistaches',
    'allergy_noix_de_pecan',
    'allergy_noix_du_bresil',
    'allergy_noix_de_macadamia',
    'allergy_lait',
    'allergy_oeufs',
    'allergy_soja',
    'allergy_ble',
    'allergy_poisson',
    'allergy_crevettes',
    'allergy_crabes',
    'allergy_homards',
    'allergy_moules',
    'allergy_huitres',
    'allergy_palourdes',
    'allergy_sesame',
    'allergy_moutarde',
    'allergy_celeri',
    'allergy_lupin',
    'allergy_mais',
    'allergy_riz',
    'allergy_avoine',
    'allergy_orge',
    'allergy_seigle',
    'allergy_graines_de_tournesol',
    'allergy_graines_de_citrouille',
    'allergy_graines_de_pavot',
    'allergy_cannelle',
    'allergy_clou_de_girofle',
    'allergy_levure',
    'allergy_glutamate_monosodique',
    'allergy_sulfites',
    'allergy_tartrazine',
    'allergy_benzoates',
    'allergy_sorbates',
    'allergy_avocat',
    'allergy_banane',
    'allergy_kiwi',
    'allergy_mangue',
    'allergy_noix_de_coco',
    'allergy_huile_de_sesame',
    'allergy_huile_d_arachide',
  ];

  late UserPreferences userPrefs;
  List<String> _selectedAllergies = [];

  @override
  void initState() {
    super.initState();
    userPrefs = Provider.of<UserPreferences>(context, listen: false);
    _selectedAllergies = List.from(userPrefs.allergies);
  }

  @override
  void dispose() {
    userPrefs.setAllergies(_selectedAllergies);
    super.dispose();
  }

  void _toggleAllergy(String allergyKey) {
    setState(() {
      if (_selectedAllergies.contains(allergyKey)) {
        _selectedAllergies.remove(allergyKey);
      } else {
        _selectedAllergies.add(allergyKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      appBar: AppBar(
        title: Text(
          localizations.allergiesTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: userPrefs.backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                localizations.allergiesHint,
                style: TextStyle(color: userPrefs.textColor, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: _possibleAllergiesKeys.map((allergyKey) {
                  final isSelected = _selectedAllergies.contains(allergyKey);
                  String allergyLabel = '';
                  switch (allergyKey) {
                    case 'allergy_arachides':
                      allergyLabel = localizations.allergy_arachides;
                      break;
                    case 'allergy_amandes':
                      allergyLabel = localizations.allergy_amandes;
                      break;
                    case 'allergy_noix':
                      allergyLabel = localizations.allergy_noix;
                      break;
                    case 'allergy_noisettes':
                      allergyLabel = localizations.allergy_noisettes;
                      break;
                    case 'allergy_noix_de_cajou':
                      allergyLabel = localizations.allergy_noix_de_cajou;
                      break;
                    case 'allergy_pistaches':
                      allergyLabel = localizations.allergy_pistaches;
                      break;
                    case 'allergy_noix_de_pecan':
                      allergyLabel = localizations.allergy_noix_de_pecan;
                      break;
                    case 'allergy_noix_du_bresil':
                      allergyLabel = localizations.allergy_noix_du_bresil;
                      break;
                    case 'allergy_noix_de_macadamia':
                      allergyLabel = localizations.allergy_noix_de_macadamia;
                      break;
                    case 'allergy_lait':
                      allergyLabel = localizations.allergy_lait;
                      break;
                    case 'allergy_oeufs':
                      allergyLabel = localizations.allergy_oeufs;
                      break;
                    case 'allergy_soja':
                      allergyLabel = localizations.allergy_soja;
                      break;
                    case 'allergy_ble':
                      allergyLabel = localizations.allergy_ble;
                      break;
                    case 'allergy_poisson':
                      allergyLabel = localizations.allergy_poisson;
                      break;
                    case 'allergy_crevettes':
                      allergyLabel = localizations.allergy_crevettes;
                      break;
                    case 'allergy_crabes':
                      allergyLabel = localizations.allergy_crabes;
                      break;
                    case 'allergy_homards':
                      allergyLabel = localizations.allergy_homards;
                      break;
                    case 'allergy_moules':
                      allergyLabel = localizations.allergy_moules;
                      break;
                    case 'allergy_huitres':
                      allergyLabel = localizations.allergy_huitres;
                      break;
                    case 'allergy_palourdes':
                      allergyLabel = localizations.allergy_palourdes;
                      break;
                    case 'allergy_sesame':
                      allergyLabel = localizations.allergy_sesame;
                      break;
                    case 'allergy_moutarde':
                      allergyLabel = localizations.allergy_moutarde;
                      break;
                    case 'allergy_celeri':
                      allergyLabel = localizations.allergy_celeri;
                      break;
                    case 'allergy_lupin':
                      allergyLabel = localizations.allergy_lupin;
                      break;
                    case 'allergy_mais':
                      allergyLabel = localizations.allergy_mais;
                      break;
                    case 'allergy_riz':
                      allergyLabel = localizations.allergy_riz;
                      break;
                    case 'allergy_avoine':
                      allergyLabel = localizations.allergy_avoine;
                      break;
                    case 'allergy_orge':
                      allergyLabel = localizations.allergy_orge;
                      break;
                    case 'allergy_seigle':
                      allergyLabel = localizations.allergy_seigle;
                      break;
                    case 'allergy_graines_de_tournesol':
                      allergyLabel = localizations.allergy_graines_de_tournesol;
                      break;
                    case 'allergy_graines_de_citrouille':
                      allergyLabel = localizations.allergy_graines_de_citrouille;
                      break;
                    case 'allergy_graines_de_pavot':
                      allergyLabel = localizations.allergy_graines_de_pavot;
                      break;
                    case 'allergy_cannelle':
                      allergyLabel = localizations.allergy_cannelle;
                      break;
                    case 'allergy_clou_de_girofle':
                      allergyLabel = localizations.allergy_clou_de_girofle;
                      break;
                    case 'allergy_levure':
                      allergyLabel = localizations.allergy_levure;
                      break;
                    case 'allergy_glutamate_monosodique':
                      allergyLabel = localizations.allergy_glutamate_monosodique;
                      break;
                    case 'allergy_sulfites':
                      allergyLabel = localizations.allergy_sulfites;
                      break;
                    case 'allergy_tartrazine':
                      allergyLabel = localizations.allergy_tartrazine;
                      break;
                    case 'allergy_benzoates':
                      allergyLabel = localizations.allergy_benzoates;
                      break;
                    case 'allergy_sorbates':
                      allergyLabel = localizations.allergy_sorbates;
                      break;
                    case 'allergy_avocat':
                      allergyLabel = localizations.allergy_avocat;
                      break;
                    case 'allergy_banane':
                      allergyLabel = localizations.allergy_banane;
                      break;
                    case 'allergy_kiwi':
                      allergyLabel = localizations.allergy_kiwi;
                      break;
                    case 'allergy_mangue':
                      allergyLabel = localizations.allergy_mangue;
                      break;
                    case 'allergy_noix_de_coco':
                      allergyLabel = localizations.allergy_noix_de_coco;
                      break;
                    case 'allergy_huile_de_sesame':
                      allergyLabel = localizations.allergy_huile_de_sesame;
                      break;
                    case 'allergy_huile_d_arachide':
                      allergyLabel = localizations.allergy_huile_d_arachide;
                      break;
                    default:
                      allergyLabel = allergyKey;
                      break;
                  }
                  return FilterChip(
                    label: Text(allergyLabel,
                        style: TextStyle(color: isSelected ? Colors.white : userPrefs.textColor)),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      _toggleAllergy(allergyKey);
                    },
                    backgroundColor: userPrefs.buttonColor,
                    selectedColor: Theme.of(context).primaryColor,
                    side: BorderSide(color: userPrefs.textColor),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}