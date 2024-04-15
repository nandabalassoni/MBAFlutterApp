import 'package:flutter/material.dart';
import 'package:mba_flutter_app/form/shopping_form_screen.dart';

import '../model/product.dart';
import '../service/product_service.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ShoppingListScreenState createState() => ShoppingListScreenState();
}

class ShoppingListScreenState extends State<ShoppingListScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    updateProductList();
  }

  void updateProductList() async {
    print('updateProductList called');
    var productService = ProductService();
    Map<String, Product> productMap = await productService.getProducts();
    print('Retrieved products: $productMap');
    List<Product> productList = productMap.values.toList();
    setState(() {
      products = productList;
    });
    print('Updated state: $products');
  }

  @override
  Widget build(BuildContext context) {
    print('Building list with ${products.length} products');
    return ListView(
      children: products.map((product) {
        print('Building Card for product: ${product.name}');
        return Card(
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.amberAccent.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ShoppingFormScreen(
                        onProductAdded: updateProductList,
                      ),
                ),
              );
            },
            child: ListTile(
              leading: const FlutterLogo(),
              title: Text(product.name),
            ),
          ),
        );
      }).toList(),
    );
  }
}