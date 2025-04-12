class Product {
  final String name;
  final double energy;   // kcal
  final double carbs;    // g
  final double fats;     // g
  final double fiber;    // g
  final double proteins; // g
  final double salt;     // g

  Product({
    required this.name,
    required this.energy,
    required this.carbs,
    required this.fats,
    required this.fiber,
    required this.proteins,
    required this.salt,
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

    return Product(
      name: product['product_name'] ?? 'Unknown',
      energy: (nutriments['energy-kcal'] ?? 0).toDouble(),
      carbs: (nutriments['carbohydrates'] ?? 0).toDouble(),
      fats: (nutriments['fat'] ?? 0).toDouble(),
      fiber: (nutriments['fiber'] ?? 0).toDouble(),
      proteins: (nutriments['proteins'] ?? 0).toDouble(),
      salt: (nutriments['salt'] ?? 0).toDouble(),
    );
  }
}
