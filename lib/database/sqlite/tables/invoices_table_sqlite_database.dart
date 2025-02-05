import 'package:invoice/constans/enums.dart';
import 'package:invoice/exceptions/sqlite_exception.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';

class InvoicesTableSqliteDatabase extends CoreSqliteDatabase {

  final SqliteTable _table = SqliteTable.invoices;

  Future<int> create(InvoiceModel invoice) async {
    try {
      Database db = await database();
      int id = await db.insert(_table.name, invoice.toMap());
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<List<InvoiceModel>> allInvoicesForOneCustomer(int customerId, {String orderBy = "updatedAt DESC"}) async {
    try {
      Database db = await database();
      List<Map<String, Object?>> result = await db.query(_table.name, where: "customerId = ?", whereArgs: [customerId], orderBy: orderBy);
      db.close();
      return result.map((item) => InvoiceModel.fromJson(item)).toList();
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<List<InvoiceModel>> all({String orderBy = "updatedAt DESC"}) async {
    try {
      Database db = await database();
      List<Map<String, Object?>> result = await db.query(_table.name, orderBy: orderBy);
      return result.map((item) => InvoiceModel.fromJson(item)).toList();
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> update(InvoiceModel invoice) async {
    try {
      Database db = await database();
      int id = await db.update(_table.name, invoice.toMap(), where: "id = ?", whereArgs: [invoice.id]);
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> customUpdate(int invoiceId, Map<String, Object?> customFields) async {
    try {
      Database db = await database();
      int id = await db.update(_table.name, customFields, where: "id = ?", whereArgs: [invoiceId]);
      db.close();
      return id;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> remove(InvoiceModel invoice) async {
    try {
      Database db = await database();
      int count = await db.delete(_table.name, where: "id = ?", whereArgs: [invoice.id]);
      db.close();
      return count;
    } catch(error) {
      throw SqliteException();
    }
  }

  Future<int> removeGroup(List<InvoiceModel> invoices) async {
    try {
      Database db = await database();
      String ids = invoices.map((invoice) => invoice.id).toList().join(', ');
      int count = await db.delete(_table.name, where: "id IN ($ids)");
      return count;
    } catch(error) {
      throw SqliteException();
    }
  }
}

/*
  SELECT 
    invoices.*, 
    customers.name as customerName, customers.nationalCode as customerNationalCode, customers.phone as customerPhone, customers.address as customerAddress, 
    invoiceProducts.productVolumeEach, invoiceProducts.quantityOfBoxes, invoiceProducts.productPriceEach, 
    products.code as productCode, products.unit as productUnit, 
    categories.name as productCategoryName, 
    invoiceBookmarks.invoiceId as bookmark 

    FROM invoices  INNER JOIN customers        ON  invoices.customerId = customers.id 
              LEFT OUTER JOIN invoiceProducts  ON  invoices.id = invoiceProducts.invoiceId 
              LEFT OUTER JOIN products         ON  invoiceProducts.productId = products.id 
              LEFT OUTER JOIN categories       ON  products.categoryId = categories.id 
              LEFT OUTER JOIN invoiceBookmarks ON  invoices.id = invoiceBookmarks.invoiceId
*/