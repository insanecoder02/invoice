import 'package:invoice/constans/enums.dart';
import 'package:invoice/exceptions/sqlite_exception.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';

class CustomersTableSqliteDatabase extends CoreSqliteDatabase {

  final SqliteTable _table = SqliteTable.customers;

  Future<int> create(CustomerModel customer) async {
    try {
      Database db = await database();
      int id = await db.insert(_table.name, customer.toMap());
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<List<CustomerModel>> all() async {
    try {
      Database db = await database();
      List<Map<String, Object?>> result = await db.query(_table.name, orderBy: "seenAt DESC");
      db.close();
      return result.map((item) => CustomerModel.fromJson(item)).toList().toList();
    } catch(error) {
      throw SqliteException();
    }
  }

  /*Future<bool> exists(String field, String value) async {
    try {
      Database db = await database();
      List<Map<String, Object?>> result = await db.rawQuery('SELECT 1 FROM $_table.name WHERE $field = \'$value\' LIMIT 1');
      return result.isNotEmpty ? true : false;
    } catch(eroor) {
      throw SqliteException();
    }
  }*/

  Future<int> update(CustomerModel customer) async {
    try {
      Database db = await database();
      int id = await db.update(_table.name, customer.toMap(), where: "id = ?", whereArgs: [customer.id]);
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> remove(CustomerModel customer) async {
    try {
      Database db = await database();
      int count = await db.delete(_table.name, where: "id = ?", whereArgs: [customer.id]);
      db.close();
      return count;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> removeGroup(List<CustomerModel> customers) async {
    try {
      Database db = await database();
      String ids = customers.map((customer) => customer.id).toList().join(', ');
      int count = await db.delete(_table.name, where: "id IN ($ids)");
      return count;
    } catch(error) {
      throw SqliteException();
    }
  }
}
