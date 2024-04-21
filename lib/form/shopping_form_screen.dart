import 'package:flutter/material.dart';
import 'package:mba_flutter_app/dao/shopping_dao.dart';
import 'package:mba_flutter_app/model/product.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:provider/provider.dart';

class ShoppingFormScreen extends StatefulWidget {
  Product? product;

  ShoppingFormScreen({super.key, this.product});

  @override
  ShoppingFormScreenState createState() => ShoppingFormScreenState();
}

class ShoppingFormScreenState extends State<ShoppingFormScreen> {
  final _nameController = TextEditingController();
  final _taxController = TextEditingController();
  final _dollarPriceController = TextEditingController();
  final _shoppingDAO = ShoppingDAO();

  String _buttonTitleSaveOrUpdate = 'Cadastrar';
  bool pagouComCartao = true;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      _nameController.text = widget.product?.name ?? '';
      _taxController.text = widget.product?.tax.toString() ?? '0.0';
      _dollarPriceController.text = widget.product?.price.toString() ?? '0.0';
      pagouComCartao = widget.product?.isPaidWithCreditCard ?? false;
      _buttonTitleSaveOrUpdate = 'Atualizar';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product != null) {
      _nameController.text = widget.product?.name ?? '';
      _taxController.text = widget.product?.tax.toString() ?? '0.0';
      _dollarPriceController.text = widget.product?.price.toString() ?? '0.0';
      // pagouComCartao = widget.product?.isPaidWithCreditCard ?? false;
      _buttonTitleSaveOrUpdate = 'Atualizar';

      return Consumer<ShoppingProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cadastro de produto'),
              backgroundColor: Colors.blueAccent.withOpacity(0.8),
              foregroundColor: Colors.white,
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
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
                        prefixIcon: const Icon(Icons.monetization_on_outlined)),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
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
                        onChanged: (bool value) {
                          setState(() {
                            pagouComCartao = value;
                          });
                        },
                        title: const Text('Pagou com cartão?'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.image_outlined),
                    label: const Text(
                      'Escolher foto',
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, bottom: 40, right: 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (widget.product != null) {
                            _shoppingDAO.delete(widget.product!.id!);
                            provider.removeProduct(widget.product!);
                            Navigator.pop(context);
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(0.8),
                          minimumSize: const Size(120, 40),
                        ),
                        child: const Text(
                          'Deletar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          if (widget.product != null) {
                            final productUpdated = Product(
                                widget.product!.id!,
                                _nameController.text,
                                double.parse(_taxController.text),
                                double.parse(_dollarPriceController.text),
                                pagouComCartao,
                                ''
                            );

                            provider.removeProduct(widget.product!);
                            provider.addProduct(productUpdated);
                            _shoppingDAO.update(productUpdated);
                            Navigator.pop(context);
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent.withOpacity(0.8),
                          minimumSize: const Size(120, 40),
                        ),
                        child: const Text(
                          'Atualizar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Consumer<ShoppingProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Cadastro de produto',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blueAccent.withOpacity(0.8),
            foregroundColor: Colors.white,
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
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
                      prefixIcon: const Icon(Icons.monetization_on_outlined)),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
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
                      onChanged: (bool value) {
                        setState(() {
                          pagouComCartao = value;
                        });
                      },
                      title: const Text('Pagou com cartão?'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: ElevatedButton.icon(
                  onPressed: () {},
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
                  child: ElevatedButton(
                    onPressed: () {
                      final productSaved = Product(
                          null,
                          _nameController.text,
                          double.parse(_taxController.text),
                          double.parse(_dollarPriceController.text),
                          pagouComCartao,
                          ''
                      );

                      provider.addProduct(productSaved);
                      _shoppingDAO.save(productSaved);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueAccent.withOpacity(0.8),
                    ),
                    child: Text(
                      _buttonTitleSaveOrUpdate,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
