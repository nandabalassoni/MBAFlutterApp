import 'package:flutter/material.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:mba_flutter_app/service/sqlite_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/product.dart';
import '../service/product_service.dart';

class ShoppingFormScreen extends StatefulWidget {
  final VoidCallback onProductAdded;

  const ShoppingFormScreen({super.key, required this.onProductAdded});

  @override
  ShoppingFormScreenState createState() => ShoppingFormScreenState();

}

class ShoppingFormScreenState extends State<ShoppingFormScreen>{

  final _nameController = TextEditingController();
  final _taxController= TextEditingController();
  final _dollarPriceController = TextEditingController();

  bool pagouComCartao = true;

  void _saveData() async {

    try {
      Product product = Product(
          null, //id
          _nameController.text, // name
          double.parse(_taxController.text), // tax
          double.parse(_dollarPriceController.text), // price
          pagouComCartao, // isPaidwithCreditCard
          '' // urlPhoto - você precisa fornecer um valor para urlPhoto
      );

      //Cria uma nova instância do SqliteService
      late SqliteService _sqliteService;
      _sqliteService = SqliteService();

      // Cria uma nova instância do ProductService
      // ProductService productService = ProductService();

      // Salva o produto usando o ProductService
      // await productService.saveProduct(product);

      //Salva o produto a tabela Products usando o SqliteService
      int result = 0;
      result = await _sqliteService.createProduct(product);
      print('Result $result');

      // Chama o callback para informar que um novo produto foi adicionado
      widget.onProductAdded();

      // Retorna para a tela anterior
      Navigator.pop(context);
    } catch (error) {
      print('Error saving product: $error');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('error saving'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingProvider>(
      builder: (context, provider, _) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Cadastro de produto'),
              backgroundColor: Colors.greenAccent,
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 40, right: 20),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Nome do produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.people_alt_outlined),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: TextField(
                    controller: _taxController,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: 'Imposto do ESTADO (%)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.money_off_outlined),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: TextField(
                    controller: _dollarPriceController,
                    decoration: InputDecoration(
                        filled: true,
                        labelText: 'Valor do produto em U\$',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(Icons.monetization_on_outlined)
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      SwitchListTile(
                        secondary: const Icon(Icons.credit_card),
                        value: pagouComCartao,
                        onChanged: (bool value) {},
                        title: const Text('Pagou com cartão?'),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ElevatedButton.icon(
                    onPressed: (){},
                    icon: const Icon(Icons.image_outlined),
                    label: const Text(
                      'Escolher foto',
                    ),
                  ),
                ),

                const Spacer(),

                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 40, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child:
                    ElevatedButton(
                      onPressed: () {
                        provider.addProduct(Product(
                            null, //id
                            _nameController.text, // name
                            double.parse(_taxController.text), // tax
                            double.parse(_dollarPriceController.text), // price
                            pagouComCartao, // isPaidwithCreditCard
                            '' // urlPhoto - você precisa fornecer um valor para urlPhoto
                        ));
                        _saveData();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.greenAccent.withOpacity(0.7),
                      ),
                      child: const Text('Cadastrar'),
                    ),
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}