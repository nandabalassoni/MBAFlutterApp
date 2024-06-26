import 'package:mba_flutter_app/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteRepository {

 //Inicializa o banco de dados SQLite
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE Products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, tax REAL, price REAL, isPaidWithCreditCard INTEGER, urlPhoto TEXT)",
        );
      },
      version: 1,
    );
  }

  // Insere um produto na tabela Products e retorna o id
  Future<int> createProduct(Product product) async {
    final Database db = await initializeDB();
    return await db.insert(
        'Products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateProduct(Product product) async {
    final Database db = await initializeDB();
    db.update('Products', {'name': product.name, 'tax': product.tax, 'price': product.price, 'isPaidWithCreditCard': product.isPaidWithCreditCard, 'urlPhoto': product.urlPhoto}, where: 'id = ?', whereArgs: [product.id]);
  }

  deleteProduct(int id) async {
    final Database db = await initializeDB();
    db.delete('Products', where: 'id = ?', whereArgs: [id]);
  }

  //Retorna a lista de todos os produtos cadastrados na tabela Products
  Future<List<Product>> getProducts() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('Products');
    return queryResult.map((e) => Product.fromMap(e)).toList();
  }
}