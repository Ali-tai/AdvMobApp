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
  // Define a list of possible allergies
  final List<String> _possibleAllergies = [
    'Arachides',
    'Amandes',
    'Noix',
    'Noisettes',
    'Noix de cajou',
    'Pistaches',
    'Noix de pécan',
    'Noix du Brésil',
    'Noix de macadamia',
    'Lait',
    'Œufs',
    'Soja',
    'Blé',
    'Poisson',
    'Crevettes',
    'Crabes',
    'Homards',
    'Moules',
    'Huîtres',
    'Palourdes',
    'Sésame',
    'Moutarde',
    'Céleri',
    'Lupin',
    'Maïs',
    'Riz',
    'Avoine',
    'Orge',
    'Seigle',
    'Graines de tournesol',
    'Graines de citrouille',
    'Graines de pavot',
    'Cannelle',
    'Clou de girofle',
    'Levure',
    'Glutamate monosodique (MSG)',
    'Sulfites',
    'Tartrazine',
    // Ajoutez d'autres colorants si nécessaire
    'Benzoates',
    'Sorbates',
    // Ajoutez d'autres conservateurs si nécessaire
    'Avocat',
    'Banane',
    'Kiwi',
    'Mangue',
    'Noix de coco',
    'Huile de sésame',
    'Huile d\'arachide',
    // Vous pouvez choisir de ne pas inclure les allergies environnementales/autres
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

  void _toggleAllergy(String allergy) {
    setState(() {
      if (_selectedAllergies.contains(allergy)) {
        _selectedAllergies.remove(allergy);
      } else {
        _selectedAllergies.add(allergy);
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
                localizations.allergiesHint.replaceFirst('Enter', 'Select'),
                style: TextStyle(color: userPrefs.textColor, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: _possibleAllergies.map((allergy) {
                  final isSelected = _selectedAllergies.contains(allergy);
                  return FilterChip(
                    label: Text(allergy, style: TextStyle(color: isSelected ? Colors.white : userPrefs.textColor)),
                    selected: isSelected,
                    onSelected: (bool selected) {
                      _toggleAllergy(allergy);
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