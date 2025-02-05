import 'dart:convert';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/sqlite_migrations.dart';
import 'package:invoice/exceptions/sqlite_exception.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:encrypt/encrypt.dart';

class CoreSqliteDatabase {

  final List<SqliteTable> _tables = [
    SqliteTable.settings,
    SqliteTable.categories,
    SqliteTable.products,
    SqliteTable.customers,
    SqliteTable.invoices,
    SqliteTable.invoiceProducts
  ];

  List<String> get _tablesList => _tables.map((table) => table.name).toList();

  Future<Database> database() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), Config.sqliteDb),
        onOpen: (db) async => _onOpen(db),
        onCreate: (db, version) async => await _onCreate(db, version),
        version: Config.sqliteVersion
      );
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<void> _onOpen(db) async {
    try {
      await db.execute("PRAGMA foreign_keys=ON");
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<void> _onCreate(db, version) async {
    try {
      await SqliteMigrations.settingsMigration(db);
      await SqliteMigrations.categoriesMigration(db);
      await SqliteMigrations.productsMigration(db);
      await SqliteMigrations.customersMigration(db);
      await SqliteMigrations.invoicesMigration(db);
      await SqliteMigrations.invoiceProductsMigration(db);

      await db.insert('settings', {'passcode': null, 'autoLockDuration': 0, 'fingerprint': 0, 'quantityOfAuthAttempts': 0});
      db.close();
    } catch(error) {
      throw SqliteException();
    }
  }
  
  Future<dynamic> backupDatabase({bool isEncrypted = false}) async {
    try {
      List data = [];
      List<Map<String, dynamic>> listMaps = [];
      Database db = await database();
      List<String> tables = _tablesList;

      for (int i = 0; i < tables.length; i++) {
        listMaps = await db.query(tables[i]); 
        data.add(listMaps);
      }

      List backups = [tables, data];
      String json = jsonEncode(backups);

      if(isEncrypted) {
        var key = Key.fromUtf8(Config.sqliteSecretKey);
        final iv = IV.fromUtf8(Config.sqliteSecretKey);
        var encrypter = Encrypter(AES(key));
        var encrypted = encrypter.encrypt(json, iv: iv);

        return encrypted.base64;
      } else {
        return json;
      }
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<void> restoreDatabase(String backup, {bool isEncrypted = false}) async {
    try {
      Database db = await database();
      Batch batch = db.batch();
      
      var key = Key.fromUtf8(Config.sqliteSecretKey);
      var iv = IV.fromUtf8(Config.sqliteSecretKey);
      var encrypter = Encrypter(AES(key));
      List json = jsonDecode(isEncrypted ? encrypter.decrypt64(backup, iv: iv) : backup);

      for (int i = 0; i < json[0].length; i++) {
        for (int k = 0; k < json[1][i].length; k++) {
          batch.insert(json[0][i], json[1][i][k]);
        }
      }

      await batch.commit(continueOnError: false, noResult: true);
    } catch(error) {
      throw SqliteException();
    }
  }

  Future clearDatabse() async {
    try {
      Database db = await database();
      for (String table  in _tablesList) {
        await db.delete(table);
        await db.rawQuery("DELETE FROM sqlite_sequence WHERE name='$table'");
      }
    } catch(error){
      throw SqliteException();
    }
  }

  Future<void> dropDatabase() async {
    try {
      await deleteDatabase(join(await getDatabasesPath(), Config.sqliteDb));
    } catch(error) {
      throw SqliteException();
    }
  }
}
