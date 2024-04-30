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
  double _iofValue = 1.0;
  double _exchangeRateValue = 1.0;
  final _iofTextController = TextEditingController();
  final _exchangeRateTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingProvider>(
      builder: (context, provider, _) {
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
                keyboardType: TextInputType.number,
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, bottom: 40, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  _saveSettings(
                    provider,
                    Setting(
                      double.parse(_iofTextController.text.replaceAll(',', '.')),
                      double.parse(_exchangeRateTextController.text.replaceAll(',', '.')),
                    ),
                  );
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

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _iofValue = prefs.getDouble('iof') ?? 1.0;
      _exchangeRateValue = prefs.getDouble('exchangeRate') ?? 1.0;
      _iofTextController.text = _iofValue.toString();
      _exchangeRateTextController.text = _exchangeRateValue.toString();
    });
  }

  _saveSettings(ShoppingProvider provider, Setting setting) {
    if (setting.exchangeRate <= 0.0) {
      _showMessage('A cotação do dolar deve ser maior que 0.0');
      return;
    }

    if (setting.iof <= 0.0) {
      _showMessage('O IOF deve ser maior que 0.0');
    }

    provider.updateSetting(setting);
    _showMessage('Ajustes atualizados.');
  }

  _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
