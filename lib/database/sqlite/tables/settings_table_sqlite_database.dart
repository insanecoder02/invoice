import 'package:invoice/constans/enums.dart';
import 'package:invoice/exceptions/sqlite_exception.dart';
import 'package:sqflite/sqflite.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';

class SettingsTableSqliteDatabase extends CoreSqliteDatabase {

  final SqliteTable _table = SqliteTable.settings;

  Future<Map<String, Object?>> select() async {
    try {
      Database db = await database();
      List<Map<String, Object?>> result = await db.query(_table.name);
      db.close();
      return result[0];
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> update(Map<String, dynamic> settingMap) async {
    try {
      Database db = await database();
      int id = await db.update(_table.name, settingMap, where: "id = 1");
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }
}
