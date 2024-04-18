import 'package:flutter/foundation.dart';
import 'package:mba_flutter_app/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/setting.dart';

class ShoppingProvider extends ChangeNotifier {
  List<Product> _products = [];
  Setting _setting = Setting(0.0, 0.0);

  List<Product> get products => _products;
  Setting get setting => _setting;

  void addProduct(Product product) {
    _products.add(product);

    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);

    notifyListeners();
  }

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