import 'package:flutter/material.dart';
import 'package:mba_flutter_app/model/setting.dart';
import 'package:mba_flutter_app/provider/shoppingProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {
  double _iofValue = 0.0;
  double _exchangeRateValue = 1.0;
  final _iofTextController = TextEditingController();
  final _exchangeRateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _iofValue = prefs.getDouble('iof') ?? 0.0;
      _exchangeRateValue = prefs.getDouble('exchangeRate') ?? 1.0;
      _iofTextController.text = _iofValue.toString();
      _exchangeRateTextController.text = _exchangeRateValue.toString();
    });
  }

  Future<void> _saveValues() async {
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
              margin: const EdgeInsets.only(
                  left: 20, top: 40, right: 20, bottom: 20),
              child: TextField(
                controller: _exchangeRateTextController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Cotação do dolar em R\$',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none),
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
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: _iofTextController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'IOF (\%)',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.money_off_outlined),
                ),
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, bottom: 40, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Ajustes atualizados com sucesso.')));
                  prefsProvider.updateSetting(Setting(
                      double.parse(_iofTextController.text),
                      double.parse(_exchangeRateTextController.text)));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent.withOpacity(0.8),
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
