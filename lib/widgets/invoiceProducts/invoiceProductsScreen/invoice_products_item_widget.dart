import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/invoice_products_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, toPersianNumber, switchColor, navigatorByPop, navigatorByPushNamed, showDialogWidget;
import 'package:invoice/models/category_model.dart';
import 'package:invoice/models/invoice_product_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/states/product_state.dart';

class InvoiceProductsItemWidget extends StatelessWidget {

  final InvoiceProductModel invoiceProduct;
  
  final int index;

  const InvoiceProductsItemWidget(this.invoiceProduct, this.index, {super.key});

  void _invoiceEditHandler(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    List<ProductModel> products =  getProductState(context, listen: false).products;
    ProductModel product = products.where((product) => product.id == invoiceProduct.productId).first;
    globalFormState.setFormMode(FormMode.update);
    globalFormState.setFormData({...invoiceProduct.toMap(), "productCode": product.code, 'currentProductId': product.id});
    navigatorByPushNamed(context, '/invoice/products/form');
  }

  void _deleteHandler(BuildContext context) {
    showDialogWidget(context,
      content: Text(t(context).areYouSure(t(context).delete)),
      actions: [
          TextButton(
            child: Text(t(context).cancel),
            onPressed: () => navigatorByPop(context, result: false),
          ),
          const SizedBox(width: 20.0),
          TextButton(
            child: Text(t(context).removeForever),
            onPressed: () => navigatorByPop(context, result: true),
          )
        ]
    ).then((result) {
      if(result) {
        InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
        InvoiceProductsTableSqliteDatabase().remove(invoiceProduct, invoiceProductsState.invoice.id!).then((int count) {
          if(count > 0) {
            invoiceProductsState.removeInvoiceProduct(context, invoiceProduct);
            getInvoiceState(context, listen: false).updateInvoice(invoiceProductsState.invoice);
          }
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = getProductState(context).products;
    List<CategoryModel> categories = getCategoryState(context).categories;
    ProductModel product = products.where((ProductModel product) => product.id == invoiceProduct.productId).first;
    String productCategoryName = categories.where((CategoryModel category) => category.id == product.categoryId).first.name;
    int total = (product.quantityInBox * invoiceProduct.quantityOfBoxes) * invoiceProduct.productPriceEach;

    return ListTile(
      onTap: () => _invoiceEditHandler(context),
      contentPadding: EdgeInsets.only(left: isRTL(context) ? 5.0 : 20.0, right: isRTL(context) ? 20.0 : 5.0, top: 10.0, bottom: 10.0),
      tileColor: index.isOdd ? switchColor(context, light: Colors.grey.shade50, dark: Colors.blueGrey.shade800.withOpacity(.3)) : switchColor(context, light: Colors.grey.shade100, dark: Colors.blueGrey.shade800.withOpacity(.4)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(toPersianNumber(context, product.code, onlyConvert : true), style: Theme.of(context).textTheme.headlineSmall),
          Text("$productCategoryName ${product.name}", style: Theme.of(context).textTheme.headlineMedium),
          Row(
            children: [
              Text("${toPersianNumber(context, invoiceProduct.productVolumeEach.toString(), onlyConvert: true)} ${product.unit == 0 ? t(context).gram : t(context).cc} - ${toPersianNumber(context, product.quantityInBox.toString(), onlyConvert: true)} ${t(context).numbers} - ", style: Theme.of(context).textTheme.headlineSmall),
              Expanded(child: Text("${toPersianNumber(context, invoiceProduct.quantityOfBoxes.toString(), onlyConvert: true)} ${t(context).box}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.0))),
            ],
          ),
          Row(
            children: [
              Text(t(context).priceEach, style: Theme.of(context).textTheme.headlineSmall),
              Expanded(child: Text(" ${toPersianNumber(context, invoiceProduct.productPriceEach.toString())} ${t(context).rial}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.0)))
            ],
          ),
          Row(
            children: [
              Text(t(context).total, style: Theme.of(context).textTheme.headlineSmall),
              Expanded(child: Text(" ${toPersianNumber(context, total.toString())} ${t(context).rial}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.0)))
            ],
          )
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.primary.withOpacity(.5)),
        onPressed: () => _deleteHandler(context)
      ),
    );
  }
}
