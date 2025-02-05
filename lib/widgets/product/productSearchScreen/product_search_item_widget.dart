import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/products_table_sqlite_database.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/functions/core_function.dart' show t, switchColor, toPersianNumber, navigatorByPop, showSnackBarWidget;
import 'package:invoice/states/product_state.dart';

class ProductSearchItemWidget extends StatelessWidget {

  final Map<String, ProductModel> product;

  final int index;

  const ProductSearchItemWidget(this.product, this.index, {super.key});

  void _redirectToCInvoiceProductForm(BuildContext context) {
    ProductModel productModel = ProductModel.fromJson({...product["productOriginal"]!.toMap(), 'seenAt': DateTime.now().toString()});
    ProductsTableSqliteDatabase().update(productModel).then((int id) {
      getProductState(context, listen: false).updateProduct(productModel);
      navigatorByPop(context, result: product["productWithCategory"]);
    }).catchError((error) {
      showSnackBarWidget(context, content: Text(t(context).dbError), duration: const Duration(seconds: 3));
      navigatorByPop(context, result: product["productWithCategory"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      tileColor: index.isOdd ? switchColor(context, light: Colors.grey.shade50, dark: Colors.blueGrey.shade800.withOpacity(.3)) : switchColor(context, light: Colors.grey.shade100, dark: Colors.blueGrey.shade800.withOpacity(.4)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(toPersianNumber(context, product["productWithCategory"]!.code, onlyConvert: true)),
          Text(product["productWithCategory"]!.name, style: Theme.of(context).textTheme.headlineMedium)
        ]
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${toPersianNumber(context, product["productWithCategory"]!.volume.toString(), onlyConvert: true)} ${product["productWithCategory"]!.unit == 0 ? t(context).gram : t(context).cc} - ${toPersianNumber(context, product["productWithCategory"]!.quantityInBox.toString(), onlyConvert: true)} ${t(context).numbers}", style: Theme.of(context).textTheme.headlineSmall),
          Row(
            children: [
              Text(t(context).priceEach, style: Theme.of(context).textTheme.headlineSmall),
              Expanded(child: Text(" ${toPersianNumber(context, product["productWithCategory"]!.price.toString())} ${t(context).rial}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.0)))
            ],
          ),
        ]
      ),
      onTap: () => _redirectToCInvoiceProductForm(context),
    );
  }
}
