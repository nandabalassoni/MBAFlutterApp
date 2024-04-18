import 'package:flutter/material.dart';
import 'package:mba_flutter_app/dao/shopping_dao.dart';
import 'package:mba_flutter_app/form/shopping_form_screen.dart';
import 'package:mba_flutter_app/model/product.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:mba_flutter_app/service/sqlite_service.dart';
import 'package:provider/provider.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ShoppingListScreenState createState() => ShoppingListScreenState();
}

class ShoppingListScreenState extends State<ShoppingListScreen> {
  List<Product> _products = [];
  final _shoppingDAO = ShoppingDAO();

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() async {
    if (_products.isEmpty) {
      List<Product> listP = await _shoppingDAO.getAllProduct();

      setState(() {
        _products = listP;

        for(final product in _products) {
          Provider.of<ShoppingProvider>(context, listen: false).addProduct(product);
        }
      });
    }
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
                splashColor: Colors.white,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ShoppingFormScreen(
                            product: provider.products[index],
                          ),
                    ),
                  );
                },
                child: ListTile(
                  leading: const FlutterLogo(),
                  title: Text(provider.products[index].name,),
                ),
              ),
            );
          },
        );
      },
    );
  }
}