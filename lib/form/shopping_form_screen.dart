import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mba_flutter_app/dao/shopping_dao.dart';
import 'package:mba_flutter_app/model/product.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:mba_flutter_app/widget/image_preview.dart';
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
  String _imagePath = "";
  bool _isPaidWithCreditCard = true;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      _nameController.text = widget.product?.name ?? '';
      _taxController.text = widget.product?.tax.toString() ?? '0.0';
      _dollarPriceController.text = widget.product?.price.toString() ?? '0.0';
      _isPaidWithCreditCard = widget.product?.isPaidWithCreditCard ?? false;
      _imagePath = widget.product?.urlPhoto ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
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
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
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
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
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
                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                  ),
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
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
                      value: _isPaidWithCreditCard,
                      onChanged: (bool value) {
                        setState(() {
                          _isPaidWithCreditCard = value;
                        });
                      },
                      title: const Text('Pagou com cartão?'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Row(
                  children: [
                    _imagePath.isNotEmpty ? ImagePreview(_imagePath) : const Text(''),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          setState(() {
                            print('image.path: ${image.path}');
                            _imagePath = image.path;
                          });
                        }
                      },
                      icon: const Icon(Icons.image_outlined),
                      label: const Text(
                        'Escolher foto',
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              widget.product != null
                  ? SaveAndDeleteButton(
                      _nameController.text,
                      double.parse(_taxController.text.isEmpty
                          ? '0.0'
                          : _taxController.text),
                      double.parse(_dollarPriceController.text.isEmpty
                          ? '0.0'
                          : _dollarPriceController.text),
                      _isPaidWithCreditCard,
                      _imagePath,
                      widget.product!,
                      _shoppingDAO,
                      provider)
                  : SaveButton(
                      _nameController.text,
                      double.parse(_taxController.text.isEmpty
                          ? '0.0'
                          : _taxController.text),
                      double.parse(_dollarPriceController.text.isEmpty
                          ? '0.0'
                          : _dollarPriceController.text),
                      _isPaidWithCreditCard,
                      _imagePath,
                      provider,
                      _shoppingDAO),
            ],
          ),
        );
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  String name;
  double tax;
  double dollar;
  bool isPaidWithCreditCard;
  String imagePath;
  ShoppingProvider provider;
  ShoppingDAO shoppingDAO;

  SaveButton(this.name, this.tax, this.dollar, this.isPaidWithCreditCard,
      this.imagePath, this.provider, this.shoppingDAO,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 40, right: 20),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            final productSaved = Product(
                null, name, tax, dollar, isPaidWithCreditCard, imagePath);

            provider.addProduct(productSaved);
            shoppingDAO.save(productSaved);
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent.withOpacity(0.8),
          ),
          child: const Text(
            'Cadastrar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SaveAndDeleteButton extends StatelessWidget {
  String name;
  double tax;
  double dollar;
  bool isPaidWithCreditCard;
  String imagePath;
  Product product;
  ShoppingDAO shoppingDAO;
  ShoppingProvider provider;

  SaveAndDeleteButton(
      this.name,
      this.tax,
      this.dollar,
      this.isPaidWithCreditCard,
      this.imagePath,
      this.product,
      this.shoppingDAO,
      this.provider,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 40, right: 20),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              shoppingDAO.delete(product.id!);
              provider.removeProduct(product);
              Navigator.pop(context);
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
              final productUpdated = Product(product.id, name, tax, dollar,
                  isPaidWithCreditCard, imagePath);

              provider.removeProduct(product);
              provider.addProduct(productUpdated);
              shoppingDAO.update(productUpdated);
              Navigator.pop(context);
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
    );
  }
}
