import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenFoodFactsService {
  Future<Map<String, dynamic>> getProduct(String barcode) async {
    final response = await http.get(Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Impossible de charger le produit');
    }
  }
}