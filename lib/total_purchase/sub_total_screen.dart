import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/product.dart';

class SubTotalScreen extends StatelessWidget {

  final double iof = 5.38; // TODO: Pegar o valor do IOF da screen settings.
  final formatDolar = new NumberFormat.currency(locale: "en_US", symbol: "");
  final formatReal = new NumberFormat.currency(locale: "pt_BR", symbol: "");
  final products = [
    Product('iPhone 15 Pro Max', 0.1, 999.0, false, ''),
    Product('MacBook Pro', 0.2, 1999.0, false, ''),
  ]; // TODO: Pegar os produtos do User Preferences.


  SubTotalScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                '\$ ${formatDolar.format(totalPrices(products))}',
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
                '\$ ${formatDolar.format(totalPricesWithTaxes(products))}',
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
                'R\$ ${formatReal.format(totalPricesReal(100.0, 5.1))}',
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
  }

  double totalPrices(List<Product> products) {
    double totalPrices = 0.0;

    for(final product in products) {
      totalPrices += product.price;
    }

    return totalPrices;
  }

  double totalPricesWithTaxes(List<Product> products) {
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

  double totalPricesReal(double totalPricesWithTaxes, double dolarExchange) {
    return totalPricesWithTaxes * dolarExchange;
  }
}