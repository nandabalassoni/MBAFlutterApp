import 'package:flutter/material.dart';

class ShoppingFormScreen extends StatelessWidget {

  ShoppingFormScreen({super.key});

  bool pagouComCartao = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de produto'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 40, right: 20),
            child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nome do produto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.people_alt_outlined),
                ),
                keyboardType: TextInputType.text,
              ),
          ),

          Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Imposto do ESTADO (%)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.money_off_outlined),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                labelText: 'Valor do produto em U\$',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.monetization_on_outlined)
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                SwitchListTile(
                  secondary: Icon(Icons.credit_card),
                  value: pagouComCartao,
                  onChanged: (bool value) {},
                  title: Text('Pagou com cartão?'),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.image_outlined),
              label: Text(
                'Escolher foto',
              ),
            ),
          ),

          Spacer(),

          Container(
            margin: EdgeInsets.only(left: 20, bottom: 40, right: 20),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child:
              ElevatedButton(
                  onPressed: () {},
                  child: Text('Cadastrar'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.greenAccent.withOpacity(0.7),
                  ),
                ),
            ),
          ),
        ],
      )
    );
  }
}