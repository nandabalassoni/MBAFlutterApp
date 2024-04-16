import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/setting.dart';

class SettingProvider extends ChangeNotifier {
  Setting _setting = Setting(0.0, 0.0);

  Setting get setting => _setting;

  void updateSetting(Setting setting) {
    _setting.iof = setting.iof;
    _setting.exchangeRate = setting.exchangeRate;

    _saveValues(setting.iof, setting.exchangeRate);

    notifyListeners();
  }

  Future<void> _saveValues(double iof, double exchangeRate) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('iof', iof);
    prefs.setDouble('exchangeRate', exchangeRate);
  }
}