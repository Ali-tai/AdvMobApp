import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // <-- Ajouté
import 'package:nutri_tracker/providers/user_preferences.dart';
import 'package:nutri_tracker/providers/product.dart';

class InfoScreen extends StatefulWidget {
  final Map<String, dynamic> productData;

  const InfoScreen({super.key, required this.productData});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Product product;
  int quantity = 100; // Quantité par défaut en grammes
  final TextEditingController _quantityController = TextEditingController(text: '100');

  @override
  void initState() {
    super.initState();
    product = Product.fromMap(widget.productData);
  }

  Map<String, double> calculatePerQuantity(int grams, AppLocalizations localizations) {
    double factor = grams / 100;
    return {
      localizations.energy : product.energy * factor,
      localizations.carbs: product.carbs * factor,
      localizations.fats: product.fats * factor,
      localizations.fiber: product.fiber * factor,
      localizations.proteins: product.proteins * factor,
      localizations.salt: product.salt * factor,
    };
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final userPrefs = Provider.of<UserPreferences>(context);
    final Map<String, double> values = calculatePerQuantity(quantity,localizations);

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      appBar: AppBar(
          title: Text(localizations.product, style: TextStyle(color: userPrefs.textColor, fontSize: 24)),
          backgroundColor: userPrefs.appBarColor,
          centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${localizations.product} : ${product.name}',
                style: TextStyle(color: userPrefs.textColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              /// 🔢 Zone d’entrée pour la quantité
              Row(
                children: [
                  Text('${localizations.quantity} : ', style: TextStyle(color: userPrefs.textColor, fontSize: 16)),
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: localizations.enterQuantity,
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      onChanged: (value) {
                        setState(() {
                          quantity = int.tryParse(value) ?? 100;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// 📊 Affichage des valeurs nutritionnelles calculées
              ...values.entries.map((entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('${entry.key}: ${entry.value.toStringAsFixed(1)}', style: TextStyle(color: userPrefs.textColor, fontSize: 16)),
              )),

              const SizedBox(height: 30),

              /// ➕ Bouton Ajouter
              ElevatedButton.icon(
                onPressed: () {
                  final userPrefs = Provider.of<UserPreferences>(context, listen: false);

                  final nutriments = calculatePerQuantity(quantity, localizations);

                  userPrefs.addEnergy(nutriments['Énergie']!.toInt());
                  userPrefs.addCarbs(nutriments['Glucides']!.toInt());
                  userPrefs.addFats(nutriments['Lipides']!.toInt());
                  userPrefs.addFiber(nutriments['Fibres']!.toInt());
                  userPrefs.addProtein(nutriments['Protéines']!.toInt());
                  userPrefs.addSalt(nutriments['Sel']!.toInt());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.valuesAdded)),
                  );
                },
                icon: Icon(Icons.add, color: userPrefs.textColor),
                label: Text(localizations.addValues, style: TextStyle(color: userPrefs.textColor, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: userPrefs.buttonColor,
                  side: BorderSide(color: userPrefs.textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
