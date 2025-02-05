import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/settings_table_sqlite_database.dart';
import 'package:invoice/database/sqlite/tables/categories_table_sqlite_database.dart';
import 'package:invoice/database/sqlite/tables/customers_table_sqlite_database.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/database/sqlite/tables/products_table_sqlite_database.dart';
import 'package:invoice/models/category_model.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/security_state.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/states/product_state.dart';

class InitStatesPlugin {

  static Future<void> initStates(context) async {
    try {
      await initSettingsData(context);
      await initCategoriesData(context);
      await initProductsData(context);
      await initCustomersData(context);
      await initInvoicesData(context);
      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<void> initSettingsData(BuildContext context) {
    return SettingsTableSqliteDatabase().select().then((Map setting) {
      SecurityState securityState = getSecurityState(context, listen: false);
      securityState.changePasscode(setting['passcode']);
      securityState.changeAutoLockDuration(setting['autoLockDuration']);
      securityState.changeFingerprint(setting['fingerprint']);
      securityState.changeQuantityOfAuthAttempts(value: 0);
      // securityState.changeQuantityOfAuthAttempts(value: setting['quantityOfAuthAttempts']);
    });
  }

  static Future<void> initCategoriesData(BuildContext context) {
    return CategoriesTableSqliteDatabase().all().then((List<CategoryModel> categories) {
      getCategoryState(context, listen: false).addCategories(categories);
    });
  }

  static Future<void> initProductsData(BuildContext context) {
    return ProductsTableSqliteDatabase().all().then((List<ProductModel> products) {
      getProductState(context, listen: false).addProducts(products, withTemp: true);
    });
  }

  static Future<void> initCustomersData(BuildContext context) {
    return CustomersTableSqliteDatabase().all().then((List<CustomerModel> customers) {
      getCustomerState(context, listen: false).addCustomers(customers, withTemp: true);
    });
  }

  static Future<void> initInvoicesData(BuildContext context) {
    return InvoicesTableSqliteDatabase().all().then((List<InvoiceModel> invoices) {
      getInvoiceState(context, listen: false).addInvoices(invoices, withTemp: true);
    });
  }
}
