import 'package:flutter/material.dart';
import 'package:invoice/screens/splash_screen.dart';
import 'package:invoice/screens/home_screen.dart';
import 'package:invoice/screens/category/categories_screen.dart';
import 'package:invoice/screens/category/category_form_screen.dart';
import 'package:invoice/screens/product/products_screen.dart';
import 'package:invoice/screens/product/product_form_screen.dart';
import 'package:invoice/screens/product/product_search_screen.dart';
import 'package:invoice/screens/customer/customers_screen.dart';
import 'package:invoice/screens/customer/customer_form_screen.dart';
import 'package:invoice/screens/customer/customer_invoices_screen.dart';
import 'package:invoice/screens/customer/customer_search_screen.dart';
import 'package:invoice/screens/invoice/invoices_screen.dart';
import 'package:invoice/screens/invoice/invoice_form_screen.dart';
import 'package:invoice/screens/invoice/invoices_bookmarks_screen.dart';
import 'package:invoice/screens/invoiceProducts/invoice_products_screen.dart';
import 'package:invoice/screens/invoiceProducts/invoice_products_form_screen.dart';
import 'package:invoice/screens/backup_database_sqlite_screen.dart';
import 'package:invoice/screens/restore_database_sqlite_screen.dart';
import 'package:invoice/screens/passcode_screen.dart';
import 'package:invoice/screens/settings/settings_screen.dart';
import 'package:invoice/screens/language_screen.dart';
import 'package:invoice/screens/settings/security/security_screen.dart';
import 'package:invoice/screens/settings/security/security_passcode_form_screen.dart';
import 'package:invoice/screens/settings/security/security_confirm_passcode_form_screen.dart';
import 'package:invoice/screens/settings/security/security_config_screen.dart';
import 'package:invoice/screens/settings/security/security_select_autolock_duration_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/": (BuildContext context) => const SplashScreen(),
  "/home": (BuildContext context) => const HomeScreen(),
  "/categories": (BuildContext context) => const CategoriesScreen(),
  "/category/form": (BuildContext context) => const CategoryFormScreen(),
  "/products": (BuildContext context) => const ProductsScreen(),
  "/product/form": (BuildContext context) => const ProductFormScreen(),
  "/product/search": (BuildContext context) => const ProductSearchScreen(),
  "/customers": (BuildContext context) => const CustomersScreen(),
  "/customer/form": (BuildContext context) => const CustomerFormScreen(),
  "/customer/invoices": (BuildContext context) => const CustomerInvoicesScreen(),
  "/customer/search": (BuildContext context) => const CustomerSearchScreen(),
  "/invoices": (BuildContext context) => const InvoicesScreen(),
  "/invoice/form": (BuildContext context) => const InvoiceFormScreen(),
  "/invoice/bookmarks": (BuildContext context) => const InvoicesBookmarksScreen(),
  "/invoice/products": (BuildContext context) => const InvoiceProductsScreen(),
  "/invoice/products/form": (BuildContext context) => const InvoiceProductsFormScreen(),
  "/backup": (BuildContext context) => const BackupDatabaseSqliteScreen(),
  "/restore": (BuildContext context) => const RestoreDatabaseSqliteScreen(),
  "/passcode": (BuildContext context) => const PasscodeScreen(),
  "/settings": (BuildContext context) => const SettingsScreen(),
  "/settings/language": (BuildContext context) => const LanguageScreen(),
  "/settings/security": (BuildContext context) => const SecurityScreen(),
  "/settings/security/form/passcode": (BuildContext context) => const SecurityPasscodeFormScreen(),
  "/settings/security/form/confirmPasscode": (BuildContext context) => const SecurityConfirmPasscodeFormScreen(),
  "/settings/security/config": (BuildContext context) => const SecurityConfigScreen(),
  "/settings/security/config/selectAutolockDuration": (BuildContext context) => const SecuritySelectAutolockDurationScreen(),
};
