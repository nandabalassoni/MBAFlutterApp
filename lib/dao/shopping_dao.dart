import 'package:mba_flutter_app/model/product.dart';
import 'package:mba_flutter_app/service/sqlite_service.dart';

class ShoppingDAO {

  final sqliteService = SqliteService();

  void save(Product product) {
    sqliteService.createProduct(product);
  }

  void update(Product product) {
    sqliteService.updateProduct(product);
  }

  void delete(int id) {
    sqliteService.deleteProduct(id);
  }

  Future<List<Product>> getAllProduct() async {
    return sqliteService.getProducts();
  }
}