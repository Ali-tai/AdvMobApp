class Product {
  final String name;
  final double energy; // kcal
  final double carbs; // g
  final double fats; // g
  final double fiber; // g
  final double proteins; // g
  final double salt; // g
  final List<String>? ingredients;

  Product({
    required this.name,
    required this.energy,
    required this.carbs,
    required this.fats,
    required this.fiber,
    required this.proteins,
    required this.salt,
    this.ingredients,
  });


  /// Factory : Convertit un map API en Product
  factory Product.fromMap(Map<String, dynamic> data) {
    if (data.isEmpty || data['product'] == null) {
      return Product(
        name: 'Unknown',
        energy: 0.0,
        carbs: 0.0,
        fats: 0.0,
        fiber: 0.0,
        proteins: 0.0,
        salt: 0.0,
      );
    }

    final product = data['product'];
    final nutriments = product['nutriments'] ?? {};

    return Product(
      name: product['product_name'] ?? 'Unknown',
      energy: (nutriments['energy-kcal'] ?? 0).toDouble(),
      carbs: (nutriments['carbohydrates'] ?? 0).toDouble(),
      fats: (nutriments['fat'] ?? 0).toDouble(),
      fiber: (nutriments['fiber'] ?? 0).toDouble(),
      proteins: (nutriments['proteins'] ?? 0).toDouble(),
      salt: (nutriments['salt'] ?? 0).toDouble(),
      ingredients: _extractIngredients(product),
    );
  }

  /// Conversion en Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'energy': energy,
      'carbs': carbs,
      'fats': fats,
      'fiber': fiber,
      'proteins': proteins,
      'salt': salt,
      'ingredients': ingredients,
    };
  }

  /// Calcule les valeurs nutritionnelles pour une quantité donnée (en grammes)
  Map<String, double> calculatePerQuantity(int grams) {
    final factor = grams / 100;
    return {
      'Énergie': energy * factor,
      'Glucides': carbs * factor,
      'Lipides': fats * factor,
      'Fibres': fiber * factor,
      'Protéines': proteins * factor,
      'Sel': salt * factor,
    };
  }
  /// Renvoie la liste des allergènes trouvés dans les ingrédients
  List<String> getDetectedAllergens(List<String> allergyKeywords) {
    final List<String> detected = [];

    if (ingredients == null || ingredients!.isEmpty) return detected;

    final ingredientsLower = ingredients!.map((e) => e.toLowerCase()).toList();
    final allergensLower = allergyKeywords.map((e) => e.toLowerCase()).toList();

    for (final allergen in allergensLower) {
      for (final ingredient in ingredientsLower) {
        if (ingredient.contains(allergen)) {
          detected.add(allergen.toUpperCase());
          break;
        }
      }
    }

    return detected;
  }


  /// Vérifie si le produit contient des ingrédients
  bool hasIngredients() => ingredients != null && ingredients!.isNotEmpty;


}

List<String>? _extractIngredients(Map<String, dynamic> product) {
  final raw = product['ingredients_text_with_allergens_en']
      ?? product['ingredients_text_en']
      ?? product['ingredients_text'];

  if (raw != null && raw is String) {
    return raw
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }
  return null;
}
