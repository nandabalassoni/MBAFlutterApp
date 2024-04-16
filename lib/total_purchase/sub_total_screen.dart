import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mba_flutter_app/provider/settingProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/product.dart';
import '../model/setting.dart';

class SubTotalScreen extends StatefulWidget {

  const SubTotalScreen({super.key});

  @override
  State<SubTotalScreen> createState() => _SubTotalScreenState();
}

class _SubTotalScreenState extends State<SubTotalScreen> {

  final _formatDolar = NumberFormat.currency(locale: "en_US", symbol: "");
  final _formatReal = NumberFormat.currency(locale: "pt_BR", symbol: "");
  final _products = [
    Product('iPhone 15 Pro Max', 0.1, 999.0, true, ''),
    Product('MacBook Pro', 0.2, 1999.0, true, ''),
  ]; // TODO: Pegar os produtos do User Preferences.

  @override
  void initState() {
    _loadValues();
    super.initState();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();

    Provider.of<SettingProvider>(context, listen: false).updateSetting(Setting(prefs.getDouble('iof') ?? 0.0, prefs.getDouble('exchangeRate') ?? 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, prefs, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 40, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Valor dos produtos (\$)',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '\$ ${_formatDolar.format(_totalPrices(_products))}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total com impostos(\$)',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '\$ ${_formatDolar.format(_totalPricesWithTaxes(_products, prefs.setting.iof))}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Valor final em reais',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'R\$ ${_formatReal.format(_totalPricesReal(_totalPricesWithTaxes(_products, prefs.setting.iof), prefs.setting.exchangeRate))}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.green,
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

    for(final product in products) {
      totalPrices += product.price;
    }

    return totalPrices;
  }

  double _totalPricesWithTaxes(List<Product> products, double iof) {
    double totalPricesWithTaxes = 0.0;

    for(final product in products) {
      double productPrice = 0.0;

      productPrice = product.price + (product.price * product.tax / 100);

      if(product.isPaidwithCreditCard) {
        productPrice += productPrice * iof / 100;
      }

      totalPricesWithTaxes += productPrice;
    }

    return totalPricesWithTaxes;
  }

  double _totalPricesReal(double totalPricesWithTaxes, double dolarExchange) {
    return totalPricesWithTaxes * dolarExchange;
  }
}