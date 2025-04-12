import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  Map<String, double> calculatePerQuantity(int grams) {
    double factor = grams / 100;
    return {
      'Énergie': product.energy * factor,
      'Glucides': product.carbs * factor,
      'Lipides': product.fats * factor,
      'Fibres': product.fiber * factor,
      'Protéines': product.proteins * factor,
      'Sel': product.salt * factor,
    };
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, double> values = calculatePerQuantity(quantity);

    return Scaffold(
      appBar: AppBar(title: const Text('Informations nutritionnelles')),
      resizeToAvoidBottomInset: true, // Ajouté ici
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Ajouté ici
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Produit : ${product.name}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              /// 🔢 Zone d’entrée pour la quantité
              Row(
                children: [
                  const Text('Quantité (g) : ', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Entrez la quantité en g',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                child: Text('${entry.key} : ${entry.value.toStringAsFixed(1)}'),
              )),

              const SizedBox(height: 30),

              /// ➕ Bouton Ajouter
              ElevatedButton.icon(
                onPressed: () {
                  final userPrefs = Provider.of<UserPreferences>(context, listen: false);

                  final nutriments = calculatePerQuantity(quantity);

                  userPrefs.addEnergy(nutriments['Énergie']!.toInt());
                  userPrefs.addCarbs(nutriments['Glucides']!.toInt());
                  userPrefs.addFats(nutriments['Lipides']!.toInt());
                  userPrefs.addFiber(nutriments['Fibres']!.toInt());
                  userPrefs.addProtein(nutriments['Protéines']!.toInt());
                  userPrefs.addSalt(nutriments['Sel']!.toInt());

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Valeurs nutritionnelles ajoutées !')),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}