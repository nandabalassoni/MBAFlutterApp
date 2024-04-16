import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/setting.dart';

class SettingScreen extends StatefulWidget{
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingScreen> {
  double _iofValue = 0.0;
  double _exchangeRateValue = 0.0;
  final _iofTextController = TextEditingController();
  final _exchangeRateTextController = TextEditingController();



  @override
  void initState(){
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _iofValue = prefs.getDouble('iof') ?? 0.0;
      _exchangeRateValue = prefs.getDouble('exchangeRate') ?? 0.0;
      _iofTextController.text = _iofValue.toString();
      _exchangeRateTextController.text = _exchangeRateValue.toString();
    });
  }

  Future<void> _saveValues() async{
    final prefs = await SharedPreferences.getInstance();
    _iofValue = double.parse(_iofTextController.text);
    _exchangeRateValue = double.parse(_exchangeRateTextController.text);
    setState(() {
      prefs.setDouble('iof', _iofValue);
      prefs.setDouble('exchangeRate', _exchangeRateValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingProvider>(
      builder: (context, prefsProvider, _) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
                child: TextField(
                  controller: _exchangeRateTextController,
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
                  controller: _iofTextController,
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

              Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: (){
                    // _saveValues();
                    prefsProvider.updateSetting(Setting(double.parse(_iofTextController.text), double.parse(_exchangeRateTextController.text)));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.greenAccent.withOpacity(0.7),
                  ),
                  child: const Text('Salvar'),
                ),
              ),
            ]
        );
      }
    );
  }

}