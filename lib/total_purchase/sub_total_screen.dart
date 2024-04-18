import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mba_flutter_app/model/product.dart';
import 'package:mba_flutter_app/model/setting.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubTotalScreen extends StatefulWidget {
  const SubTotalScreen({super.key});

  @override
  State<SubTotalScreen> createState() => _SubTotalScreenState();
}

class _SubTotalScreenState extends State<SubTotalScreen> {
  final _formatDollar = NumberFormat.currency(locale: "en_US", symbol: '');
  final _formatReal = NumberFormat.currency(locale: "pt_BR", symbol: '');

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();

    Provider
        .of<ShoppingProvider>(context, listen: false)
        .updateSetting(
          Setting(
            prefs.getDouble('iof') ?? 0.0,
            prefs.getDouble('exchangeRate') ?? 0.0
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadValues();

    return Consumer<ShoppingProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 40, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Valor dos produtos (\$)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '\$ ${_formatDollar.format(_totalPrices(provider.products))}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total com impostos(\$)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$ ${_formatDollar.format(_totalPricesWithTaxes(provider.products, provider.setting.iof))}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Valor final em reais',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'R\$ ${_formatReal.format(_totalPricesReal(_totalPricesWithTaxes(provider.products, provider.setting.iof), provider.setting.exchangeRate))}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  double _totalPrices(List<Product> products) {
    double totalPrices = 0.0;

    for (final product in products) {
      totalPrices += product.price;
    }

    return totalPrices;
  }

  double _totalPricesWithTaxes(List<Product> products, double iof) {
    double totalPricesWithTaxes = 0.0;

    for (final product in products) {
      double productPrice = 0.0;

      productPrice = product.price + (product.price * product.tax / 100);

      if (product.isPaidWithCreditCard) {
        productPrice += productPrice * iof / 100;
      }

      totalPricesWithTaxes += productPrice;
    }

    return totalPricesWithTaxes;
  }

  double _totalPricesReal(double totalPricesWithTaxes, double dollarExchange) {
    return totalPricesWithTaxes * dollarExchange;
  }
}
