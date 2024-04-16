import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mba_flutter_app/model/product.dart';

class ProductService {
  static const _key = 'products';

  // Salva um produto
  Future<void> saveProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, Product> products = await getProducts();

    products[product.name] = product;

    // Converte o mapa de produtos em uma String JSON
    Map<String, dynamic> productMap = product.toJson();
    String productJson = json.encode(productMap);

    // Salva a String JSON nas SharedPreferences
    await prefs.setString('${_key}_${product.name}', productJson);
  }

  // Recupera todos os produtos
  Future<Map<String, Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null || jsonString.isEmpty) {
      return {};
    }

    // Converte a String JSON de volta em um mapa de produtos
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Converte o mapa de produtos em um mapa de produtos
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