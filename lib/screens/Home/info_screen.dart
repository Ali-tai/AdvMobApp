import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nutri_tracker/providers/user_preferences.dart';
import 'package:nutri_tracker/services/product.dart';

class InfoScreen extends StatefulWidget {
  final Map<String, dynamic> productData;

  const InfoScreen({super.key, required this.productData});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late Product product;
  int quantity = 100;
  final TextEditingController _quantityController = TextEditingController(text: '100');

  @override
  void initState() {
    super.initState();
    product = Product.fromMap(widget.productData);
  }

  Map<String, double> calculatePerQuantity(int grams, AppLocalizations localizations) {
    double factor = grams / 100;
    return {
      localizations.energy: product.energy * factor,
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
    final values = calculatePerQuantity(quantity, localizations);
    final allergyIngredients = product.getDetectedAllergens(userPrefs.getAllergiesText(localizations));

    return Scaffold(
      backgroundColor: userPrefs.backgroundColor,
      appBar: AppBar(
        title: Text(localizations.product, style: TextStyle(color: userPrefs.textColor, fontSize: 24)),
        backgroundColor: userPrefs.appBarColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Nom du produit
            Text(
              '${localizations.product} : ${product.name}',
              style: TextStyle(color: userPrefs.textColor, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// Quantité
            Row(
              children: [
                Text('${localizations.quantity} : ', style: TextStyle(color: userPrefs.textColor)),
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

            /// Valeurs nutritionnelles
            ...values.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('${entry.key}: ${entry.value.toStringAsFixed(1)}',
                  style: TextStyle(color: userPrefs.textColor)),
            )),
            const SizedBox(height: 30),

            /// Allergènes détectés dans les ingrédients
            Text(localizations.allergies, style: TextStyle(color: userPrefs.textColor, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            if (allergyIngredients.isEmpty)
              Text(localizations.noAllergies, style: TextStyle(color: userPrefs.textColor))
            else
              ...allergyIngredients.map((ingredient) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  ingredient,
                  style: TextStyle(color: userPrefs.textColor),
                ),
                trailing: const Icon(Icons.warning_amber_rounded, color: Colors.red),
              )),

            const SizedBox(height: 30),

            /// Ajouter aux préférences
            ElevatedButton.icon(
              onPressed: () {
                final nutriments = calculatePerQuantity(quantity, localizations);
                userPrefs.addEnergy(nutriments[localizations.energy]!.toInt());
                userPrefs.addCarbs(nutriments[localizations.carbs]!.toInt());
                userPrefs.addFats(nutriments[localizations.fats]!.toInt());
                userPrefs.addFiber(nutriments[localizations.fiber]!.toInt());
                userPrefs.addProtein(nutriments[localizations.proteins]!.toInt());
                userPrefs.addSalt(nutriments[localizations.salt]!.toInt());

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(localizations.valuesAdded)),
                );
              },
              icon: Icon(Icons.add, color: userPrefs.textColor),
              label: Text(localizations.addValues, style: TextStyle(color: userPrefs.textColor)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: userPrefs.buttonColor,
                side: BorderSide(color: userPrefs.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
