import 'package:invoice/constans/enums.dart';
import 'package:invoice/exceptions/sqlite_exception.dart';
import 'package:invoice/models/category_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';

class CategoriesTableSqliteDatabase extends CoreSqliteDatabase {

  final SqliteTable _table = SqliteTable.categories;

  Future<int> create(CategoryModel category) async {
    try {
      Database db = await database();
      int id = await db.insert(_table.name, category.toMap());
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<List<CategoryModel>> all() async {
    try {
      Database db = await database();
      List<Map<String, Object?>> result = await db.query(_table.name);
      db.close();
      return result.map((item) => CategoryModel.fromJson(item)).toList().reversed.toList();
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> update(CategoryModel category) async {
    try {
      Database db = await database();
      int id = await db.update(_table.name, category.toMap(), where: "id = ?", whereArgs: [category.id]);
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> remove(CategoryModel category) async {
    try {
      Database db = await database();
      int count = await db.delete(_table.name, where: "id = ?", whereArgs: [category.id]);
      db.close();
      return count;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> removeGroup(List<CategoryModel> categorys) async {
    try {
      Database db = await database();
      String ids = categorys.map((category) => category.id).toList().join(', ');
      int count = await db.delete(_table.name, where: "id IN ($ids)");
      return count;
    } catch(error) {
      throw SqliteException();
    }
  }
}
