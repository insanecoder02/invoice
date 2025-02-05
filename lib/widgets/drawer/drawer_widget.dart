import 'dart:math';
import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/database/sqlite/core_sqlite_database_.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPushNamed, navigatorByPop, toPersianNumber;
import 'package:invoice/models/category_model.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/widgets/drawer/drawer_header_widget.dart';
import 'package:invoice/database/sqlite/tables/categories_table_sqlite_database.dart';
import 'package:invoice/database/sqlite/tables/customers_table_sqlite_database.dart';
import 'package:invoice/database/sqlite/tables/invoice_products_table_sqlite_database.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/database/sqlite/tables/products_table_sqlite_database.dart';
import 'package:invoice/models/invoice_product_model.dart';
import 'package:invoice/plugins/bootstrap/init_states_plugin.dart';

class DrawerWidget extends StatelessWidget {
  
  const DrawerWidget({Key? key}):super(key: key);

  void _redirect(BuildContext context, String screen) {
    navigatorByPop(context);
    navigatorByPushNamed(context, screen);
  }

  double random(int min, int max) {
    return min.toDouble() + Random().nextInt(max - min);
  }

  List _getSubjects(BuildContext context) {
    List<CategoryModel> categories = getCategoryState(context).categories;
    List<ProductModel> products = getProductState(context).products;
    List<CustomerModel> customers = getCustomerState(context).customers;
    List<InvoiceModel> invoices = getInvoiceState(context).invoices;
    List<InvoiceModel> invoicesbookmarks = invoices.where((InvoiceModel invoice) => invoice.getBookmark).toList();

    return [categories, products, customers, invoices, invoicesbookmarks];
  }

  @override
  Widget build(BuildContext context) {
    final [categories, products, customers, invoices, invoicesbookmarks] = _getSubjects(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeaderWidget(),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(t(context).categories),
            trailing: Badge(
              backgroundColor: Config.brandColor,
              isLabelVisible: categories.isNotEmpty,
              label: Text(toPersianNumber(context, categories.length.toString(), onlyConvert: true), style: TextStyle(color: Config.foregroundDark)),
            ),
            onTap: () => _redirect(context, '/categories')
          ),

          ListTile(
            leading: const Icon(Icons.list),
            title: Text(t(context).products),
            trailing: Badge(
              backgroundColor: Config.brandColor,
              isLabelVisible: products.isNotEmpty,
              label: Text(toPersianNumber(context, products.length.toString(), onlyConvert: true), style: TextStyle(color: Config.foregroundDark)),
            ),
            onTap: () => _redirect(context, '/products')
          ),

          ListTile(
            leading: const Icon(Icons.supervised_user_circle_outlined),
            title: Text(t(context).customers),
            trailing: Badge(
              backgroundColor: Config.brandColor,
              isLabelVisible: customers.isNotEmpty,
              label: Text(toPersianNumber(context, customers.length.toString(), onlyConvert: true), style: TextStyle(color: Config.foregroundDark)),
            ),
            onTap: () => _redirect(context, '/customers')
          ),

          ListTile(
            leading: const Icon(Icons.list_alt_sharp),
            title: Text(t(context).invoices),
            trailing: Badge(
              backgroundColor: Config.brandColor,
              isLabelVisible: invoices.isNotEmpty,
              label: Text(toPersianNumber(context, invoices.length.toString(), onlyConvert: true), style: TextStyle(color: Config.foregroundDark)),
            ),
            onTap: () => _redirect(context, '/invoices')
          ),

          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: Text(t(context).bookmarks),
            trailing: Badge(
              backgroundColor: Config.brandColor,
              isLabelVisible: invoicesbookmarks.isNotEmpty,
              label: Text(toPersianNumber(context, invoicesbookmarks.length.toString(), onlyConvert: true), style: TextStyle(color: Config.foregroundDark)),
            ),
            onTap: () => _redirect(context, '/invoice/bookmarks')
          ),

          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: Text(t(context).backup),
            onTap: () => _redirect(context, '/backup')
          ),

          ListTile(
            leading: const Icon(Icons.settings_backup_restore),
            title: Text(t(context).restore),
            onTap: () => _redirect(context, '/restore')
          ),

          ListTile(
            leading: const Icon(Icons.data_array),
            title: Text(t(context).fakeData),
            onTap: () async {
              await CoreSqliteDatabase().dropDatabase();
              // ignore: use_build_context_synchronously
              await InitStatesPlugin.initStates(context);
              String dateTime = DateTime.now().toString();

              List<String> categoryName = ['آبمیوه', 'بیسکویت', 'تافی', 'کیک', 'ویفر'];
              for(int i = 0; i < 5; i++) {
                await CategoriesTableSqliteDatabase().create(CategoryModel(name: categoryName[i]));
              }

              List<Map> products = [
                {"categoryId": 1, "name": "نکتار هلو"}, {"categoryId": 1, "name": "رانی سیب"}, {"categoryId": 1, "name": "نکتار انبه"}, {"categoryId": 1, "name": "احلام آلبالو"}, {"categoryId": 1, "name": "نکتار آناناس"},
                {"categoryId": 2, "name": "ساقه طلایی"}, {"categoryId": 2, "name": "والس کوچک"}, {"categoryId": 2, "name": "والس بزرگ"}, {"categoryId": 2, "name": "نارگیلی"}, {"categoryId": 2, "name": "موزی"},
                {"categoryId": 3, "name": "فله ای شیری"}, {"categoryId": 3, "name": "نعنایی"}, {"categoryId": 3, "name": "شکلاتی"}, {"categoryId": 3, "name": "موزی"}, {"categoryId": 3, "name": "آناناسی"},
                {"categoryId": 4, "name": "کنجدی"}, {"categoryId": 4, "name": "خرمایی"}, {"categoryId": 4, "name": "پرتقالی"}, {"categoryId": 4, "name": "نارگیلی"}, {"categoryId": 4, "name": "نوتلایی"},
                {"categoryId": 5, "name": "دورنگ"}, {"categoryId": 5, "name": "موزی"}, {"categoryId": 5, "name": "هزار"}, {"categoryId": 5, "name": "شکلاتی"}, {"categoryId": 5, "name": "شیری"}
              ];
              for(int i = 0; i < 25; i++) {
                await ProductsTableSqliteDatabase().create(ProductModel(categoryId: products[i]["categoryId"], code: "${random(11111, 99999).toInt()}${random(11111, 99999).toInt()}", name: products[i]["name"], volume: random(200, 1000).toInt(), unit: random(1, 100).toInt() < 50 ? 0 : 1, quantityInBox: random(10, 70).toInt(), price: random(10000, 20000).toInt(), seenAt: dateTime));
              }
              
              List<String> customersNames = ["رضا پارسا", "علی عباس زاده", "ملیکا شیرانی", "محسن ابراهیمی", "مسعود محمدی", "میثم نجفی", "شاهین پارسا", "امیر رضایی", "تارا فرهادی", "مهسا امینی", "پارسا داستانی", "فردین امین", "شیدا محمدی", "شیما نگینی", "سوسن پرور", "داریوش رفیعی", "ابراهیم شاکری", "مهشید پارسایی", "حسین امیری", "علی خلیل پور"];
              for(int i = 0; i < 20; i++) {
                await CustomersTableSqliteDatabase().create(CustomerModel(name: customersNames[i], nationalCode: "${random(11111, 99999).toInt()}${random(11111, 99999).toInt()}", phone: "09${random(11, 99).toInt()}${random(11, 99).toInt()}${random(11111, 99999).toInt()}", address: "address$i", createdAt: dateTime, updatedAt: dateTime, seenAt: dateTime));
              }

              for(int i = 0; i < 30; i++) {
                await InvoicesTableSqliteDatabase().create(InvoiceModel(customerId: random(1, 20).toInt(), cashDiscount: random(0, 99).toInt(), volumeDiscount: random(0, 99).toInt(), type: random(1, 100).toInt() < 50 ? 0 : 1, bookmark: random(1, 100).toInt() < 50 ? 0 : 1, createdAt: dateTime, updatedAt: dateTime));
              }

              for(int i = 1; i <= 30; i++) {
                for(int j = 1; j <= random(3, 15).toInt(); j++) {
                  await InvoiceProductsTableSqliteDatabase().create(
                    InvoiceProductModel(invoiceId: i, productId: j, productVolumeEach: random(200, 1000).toInt(), quantityOfBoxes: random(1, 100).toInt(), productPriceEach: random(10000, 20000).toInt()),
                    i
                  );
                }
              }
              
              // ignore: use_build_context_synchronously
              InitStatesPlugin.initStates(context);
            }
          ),

          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(t(context).settings),
            onTap: () => _redirect(context, '/settings')
          ),
        ],
      ),
    );
  }
}
