import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingFormScreen extends StatefulWidget {

  ShoppingFormScreen({super.key});

  @override
  _ShoppingFormScreenState createState() => _ShoppingFormScreenState();

}

class _ShoppingFormScreenState extends State<ShoppingFormScreen>{

  final _nameController = TextEditingController();
  final _taxController= TextEditingController();
  final _dollarPriceController = TextEditingController();

  bool pagouComCartao = true;

  void _saveData() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setString('tax', _taxController.text);
      await prefs.setString('dollarPrice', _dollarPriceController.text);
      String nome = prefs.getString('name') ?? "null";
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('nome: $nome'))
      );
    }
    catch(error){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('error saving'))
      );
    }

  }

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
                controller: _nameController,
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
              controller: _taxController,
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
              controller: _dollarPriceController,
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
              onPressed: (){},
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
                  onPressed: (){
                    _saveData();
                    },
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