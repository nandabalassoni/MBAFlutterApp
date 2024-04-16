import 'package:flutter/material.dart';
import 'package:mba_flutter_app/form/shopping_form_screen.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../service/product_service.dart';
import '../service/sqlite_service.dart';

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

    // cria instancia sqlite
    final sqlite = SqliteService();

    List<Product> _p = await sqlite.getProducts();

    setState(() {
      products = _p;

      for(final product in products) {
        Provider.of<ShoppingProvider>(context, listen: false).addProduct(product);
      }

      print('products count: ${products.length}');
    });

    // print('updateProductList called');
    // var productService = ProductService();
    // Map<String, Product> productMap = await productService.getProducts();
    // print('Retrieved products: $productMap');
    // List<Product> productList = productMap.values.toList();
    // setState(() {
    //   products = productList;
    // });
    // print('Updated state: $products');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingProvider>(
      builder: (context, provider, _) {
        return ListView.builder(
          itemCount: provider.products.length,
          itemBuilder: (BuildContext context, int index) {
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
                  title: Text(provider.products[index].name),
                ),
              ),
            );
          },
        );
      },
    );
  }
}