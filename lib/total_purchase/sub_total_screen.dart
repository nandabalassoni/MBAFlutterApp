import 'package:flutter/material.dart';

class SubTotalScreen extends StatelessWidget {

  const SubTotalScreen({super.key});

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
                '\$ 0,00',
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
                '\$ 0,00',
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
                'R\$ 0,00',
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
}