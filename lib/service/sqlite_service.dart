import 'package:mba_flutter_app/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {

 //Inicializa o banco de dados SQLite
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    //print('Path: $path');

    return openDatabase(
      join(path, 'database.db'),
      //Cria a tabela Products
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
    int result = 0;
    final Database db = await initializeDB();
    return await db.insert(
        'Products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

  }

  //Retorna a lista de todos os produtos cadastrados na tabela Products
  Future<List<Product>> getProducts() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('Products');
    return queryResult.map((e) => Product.fromMap(e)).toList();
  }


}