import 'package:invoice/constans/enums.dart';
import 'package:invoice/exceptions/sqlite_exception.dart';
import 'package:invoice/models/invoice_product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';

class InvoiceProductsTableSqliteDatabase extends CoreSqliteDatabase {
  
  final SqliteTable _table = SqliteTable.invoiceProducts;

  Future<int> create(InvoiceProductModel invoiceProduct, int invoiceId) async {
    try {
      Database db = await database();
      return db.transaction((txn) async {
        var batch = txn.batch();
        int id = await txn.insert(_table.name, invoiceProduct.toMap());
        await txn.update('invoices', {'updatedAt': DateTime.now().toString()}, where: "id = ?", whereArgs: [invoiceId]);
        db.close();
        await batch.commit(noResult: true);
        return id;
      });
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<List<InvoiceProductModel>> allProductsForOneInvoice(int invoiceId) async {
    try {
      Database db = await database();
      List<Map<String, Object?>> result = await db.query(_table.name, where: "invoiceId = ?", whereArgs: [invoiceId]);
      db.close();
      return result.map((item) => InvoiceProductModel.fromJson(item)).toList().reversed.toList();
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> update(InvoiceProductModel invoiceProduct, int invoiceId) async {
    try {
      Database db = await database();
      return db.transaction((txn) async {
        var batch = txn.batch();
        int id = await txn.update(_table.name, invoiceProduct.toMap(), where: "id = ?", whereArgs: [invoiceProduct.id]);
        await txn.update('invoices', {'updatedAt': DateTime.now().toString()}, where: "id = ?", whereArgs: [invoiceId]);
        db.close();
        await batch.commit(noResult: true);
        return id;
      });
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> remove(InvoiceProductModel invoiceProduct, int invoiceId) async {
    try {
      Database db = await database();
      return db.transaction((txn) async {
        var batch = txn.batch();
        int count = await txn.delete(_table.name, where: "id = ?", whereArgs: [invoiceProduct.id]);
        await txn.update('invoices', {'updatedAt': DateTime.now().toString()}, where: "id = ?", whereArgs: [invoiceId]);
        db.close();
        await batch.commit(noResult: true);
        return count;
      });
    } catch(error) {
      throw SqliteException();
    }
  }
}
