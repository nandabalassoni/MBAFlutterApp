import 'package:mba_flutter_app/model/product.dart';
import 'package:mba_flutter_app/repository/sqlite_repository.dart';

class ShoppingDAO {
  final sqlite = SqliteRepository();

  void save(Product product) {
    sqlite.createProduct(product);
  }

  void update(Product product) {
    sqlite.updateProduct(product);
  }

  void delete(int id) {
    sqlite.deleteProduct(id);
  }

  Future<List<Product>> getAllProduct() async {
    return sqlite.getProducts();
  }
}
