import 'package:invoice/constans/enums.dart';
import 'package:invoice/exceptions/sqlite_exception.dart';
import 'package:invoice/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';

class ProductsTableSqliteDatabase extends CoreSqliteDatabase {
  
  final SqliteTable _table = SqliteTable.products;

  Future<int> create(ProductModel product) async {
    try {
      Database db = await database();
      int id = await db.insert(_table.name, product.toMap());
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<List<ProductModel>> all() async {
    try {
      Database db = await database();
      List<Map<String, Object?>> result = await db.query(_table.name, orderBy: "seenAt DESC");
      db.close();
      return result.map((item) => ProductModel.fromJson(item)).toList();
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> update(ProductModel product) async {
    try {
      Database db = await database();
      int id = await db.update(_table.name, product.toMap(), where: "id = ?", whereArgs: [product.id]);
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> remove(ProductModel product) async {
    try {
      Database db = await database();
      int count = await db.delete(_table.name, where: "id = ?", whereArgs: [product.id]);
      db.close();
      return count;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> removeGroup(List<ProductModel> products) async {
    try {
      Database db = await database();
      String ids = products.map((product) => product.id).toList().join(', ');
      int count = await db.delete(_table.name, where: "id IN ($ids)");
      return count;
    } catch(error) {
      throw SqliteException();
    }
  }
}
