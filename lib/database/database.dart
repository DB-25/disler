import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ProductDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Product ("
            "productId TEXT PRIMARY KEY,"
            "name TEXT,"
            "metaDescription TEXT,"
            "price INTEGER,"
            "retailPrice INTEGER,"
            "mrp INTEGER,"
            "imageOne TEXT,"
            "size TEXT,"
            "quantity TEXT,"
            "cart INTEGER,"
            "fav INTEGER"
            ")");
      },
    );
  }

  Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    List<Map> results =
        await db.query("Product", columns: ProductModel.columns);
    List<ProductModel> products = new List();
    results.forEach((result) {
      ProductModel product = ProductModel.fromMap(result);
      products.add(product);
    });
    return products;
  }

  insert(ProductModel product, int cart, int fav) async {
    final db = await database;
//    var maxIdResult = await db.rawQuery("SELECT MAX(primaryId)+1 as last_inserted_primaryId FROM Product");
//    var id = maxIdResult.first["last_inserted_primaryId"];
    if (await checkItem(product.productId)) {
      if (cart == 1) {
        var result = update(product, cart, 1);
        return result;
      } else if (fav == 1) {
        var result = update(product, 1, fav);
        return result;
      }
    } else {
      var result = await db.rawInsert(
          "INSERT Into Product (productId, name, metaDescription, price, retailPrice, mrp, imageOne, cart, fav, quantity, size)"
          " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
          [
            product.productId,
            product.name,
            product.metaDescription,
            product.price,
            product.retailPrice,
            product.mrp,
            product.imageOne,
            cart,
            fav,
            product.quantity,
            product.size
          ]);
      print(result);
      return result;
    }
  }

  Future<bool> checkItem(String id) async {
    final db = await database;
    var result =
        await db.rawQuery("SELECT * FROM Product WHERE productId LIKE '%$id%'");
    if (result.isNotEmpty) {
      ProductModel product = ProductModel.fromMap(result[0]);
      if (product.productId == id)
        return true;
      else
        return false;
    } else
      return false;
  }

  update(ProductModel product, int cart, int fav) async {
    final db = await database;
    var result = await db.update("Product", product.toMap(cart, fav),
        where: "productId = ?", whereArgs: [product.productId]);
    return result;
  }

  delete(String id) async {
    final db = await database;
    db.delete("Product", where: "productId = ?", whereArgs: [id]);
  }

  Future<List<ProductModel>> getCart() async {
    final db = await database;
    List<Map> results = await db.query("Product",
        columns: ProductModel.columns, where: '"cart"=?', whereArgs: [1]);
    List<ProductModel> products = new List();
    results.forEach((result) {
      ProductModel product = ProductModel.fromMap(result);
      products.add(product);
    });
    return products;
  }

  Future<List<ProductModel>> getFav() async {
    final db = await database;
    List<Map> results = await db.query("Product",
        columns: ProductModel.columns, where: '"fav"=?', whereArgs: [1]);
    List<ProductModel> products = new List();
    results.forEach((result) {
      ProductModel product = ProductModel.fromMap(result);
      products.add(product);
    });
    return products;
  }
}
