import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mba_flutter_app/model/product.dart';

class ProductService {
  static const _key = 'products';

  // Salva um produto
  Future<void> saveProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final products = await getProducts();

    products[product.name] = product.toJson() as Product;

    await prefs.setString(_key, json.encode(products));
  }

  // Recupera todos os produtos
  Future<Map<String, Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null || jsonString.isEmpty) {
      return {};
    }

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap.map((key, value) => MapEntry(key, Product.fromJson(value)));
  }

  // Atualiza um produto
  Future<void> updateProduct(Product product) async {
    return saveProduct(product);
  }

  // Deleta um produto
  Future<void> deleteProduct(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final products = await getProducts();

    products.remove(name);

    await prefs.setString(_key, json.encode(products));
  }
}