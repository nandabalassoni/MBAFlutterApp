import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Cotação do dolar em R\$',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none
                ),
                prefixIcon: Icon(Icons.monetization_on_outlined),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),

          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'IOF (\%)',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none
                  ),
                  prefixIcon: Icon(Icons.money_off_outlined),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        ]
    );
  }
}