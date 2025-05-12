class Product {
  final String name;
  final double energy; // kcal
  final double carbs; // g
  final double fats; // g
  final double fiber; // g
  final double proteins; // g
  final double salt; // g
  final List<String>? ingredients; // ADDED: Ingredients list

  Product({
    required this.name,
    required this.energy,
    required this.carbs,
    required this.fats,
    required this.fiber,
    required this.proteins,
    required this.salt,
    this.ingredients, // ADDED: Initialize ingredients
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    if (data == null || data['product'] == null) {
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
    final nutriments = data['product']['nutriments'] ?? {};

    // Extract ingredients - adjust the key based on the API response
    List<String>? ingredientsList;
    if (product['ingredients_text_with_allergens_en'] != null) {
      ingredientsList = (product['ingredients_text_with_allergens_en'] as String)
          .split(',')
          .map((s) => s.trim())
          .toList();
    } else if (product['ingredients_text_en'] != null) {
      ingredientsList = (product['ingredients_text_en'] as String)
          .split(',')
          .map((s) => s.trim())
          .toList();
    }

    return Product(
      name: product['product_name'] ?? 'Unknown',
      energy: (nutriments['energy-kcal'] ?? 0).toDouble(),
      carbs: (nutriments['carbohydrates'] ?? 0).toDouble(),
      fats: (nutriments['fat'] ?? 0).toDouble(),
      fiber: (nutriments['fiber'] ?? 0).toDouble(),
      proteins: (nutriments['proteins'] ?? 0).toDouble(),
      salt: (nutriments['salt'] ?? 0).toDouble(),
      ingredients: ingredientsList, // ADDED: Assign ingredients
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'energy': energy,
      'carbs': carbs,
      'fats': fats,
      'fiber': fiber,
      'proteins': proteins,
      'salt': salt,
      'ingredients': ingredients, // ADDED: Include ingredients in toMap
    };
  }
}