import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/products_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, switchColor, navigatorByPushNamed, showDialogWidget, navigatorByPop, toPersianNumber;
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/product_state.dart';

class ProductItemWidget extends StatelessWidget {

  final ProductModel product;

  final int index;

  const ProductItemWidget(this.product, this.index, {super.key});

  void _redirectProductToEditForm(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.update);
    globalFormState.setFormData(product.toMap());
    navigatorByPushNamed(context, '/product/form');
  }

  void _removeProductHandler(BuildContext context) {
    showDialogWidget(context,
      content: Text("${t(context).descriptionForDeleteProduct}, ${t(context).areYouSure(t(context).delete)}"),
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
        ProductState productState = getProductState(context, listen: false);
        ProductsTableSqliteDatabase().remove(product).then((int count) {
          productState.removeProduct(context, product);

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: isRTL(context) ? 10.0 : 20.0, right: isRTL(context) ? 20.0 : 10.0, top: 10.0, bottom: 10.0),
      tileColor: index.isOdd ? switchColor(context, light: Colors.grey.shade50, dark: Colors.blueGrey.shade800.withOpacity(.3)) : switchColor(context, light: Colors.grey.shade100, dark: Colors.blueGrey.shade800.withOpacity(.4)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(toPersianNumber(context, product.code, onlyConvert: true)),
          Text("${getCategoryState(context).categories.where((category) => category.id == product.categoryId).first.name} ${product.name}", style: Theme.of(context).textTheme.headlineMedium)
        ]
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${toPersianNumber(context, product.volume.toString(), onlyConvert: true)} ${product.unit == 0 ? t(context).gram : t(context).cc} - ${toPersianNumber(context, product.quantityInBox.toString(), onlyConvert: true)} ${t(context).numbers}", style: Theme.of(context).textTheme.headlineSmall),
          Row(
            children: [
              Text(t(context).priceEach, style: Theme.of(context).textTheme.headlineSmall),
              Expanded(child: Text(" ${toPersianNumber(context, product.price.toString())} ${t(context).rial}", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 16.0)))
            ],
          ),
        ]
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.primary.withOpacity(.5)),
        onPressed: () =>_removeProductHandler(context),
      ),
      onTap: () => _redirectProductToEditForm(context),
      onLongPress: () {},
    );
  }
}
