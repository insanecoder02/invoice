import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/categories_table_sqlite_database.dart';
import 'package:invoice/models/category_model.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, switchColor, navigatorByPushNamed, showDialogWidget, navigatorByPop, toPersianNumber;
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/product_state.dart';

class CategoryItemWidget extends StatelessWidget {
  
  final int index;

  final CategoryModel category;

  const CategoryItemWidget(this.index, this.category, {super.key});

  void _redirectCategoryToEditForm(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.update);
    globalFormState.setFormData(category.toMap());
    navigatorByPushNamed(context, '/category/form');
  }

  void _removeCategoryHandler(BuildContext context) {
    showDialogWidget(context,
      content: Text("${t(context).descriptionForDeleteCategory}, ${t(context).areYouSure(t(context).delete)}"),
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
        CategoryState categoryState = getCategoryState(context, listen: false);
        CategoriesTableSqliteDatabase().remove(category).then((int count) {
          categoryState.removeCategory(category);
          ProductState productState = getProductState(context, listen: false);
          productState.removeCategoryProducts(category.id ?? 0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> categoryProducts = getProductState(context).products.where((product) => product.categoryId == category.id).toList();

    return ListTile(
      tileColor: index.isOdd ? switchColor(context, light: Colors.grey.shade50, dark: Colors.blueGrey.shade800.withOpacity(.3)) : switchColor(context, light: Colors.grey.shade100, dark: Colors.blueGrey.shade800.withOpacity(.4)),
      contentPadding: EdgeInsets.only(left: isRTL(context) ? 10.0 : 20.0, right: isRTL(context) ? 20.0 : 10.0),
      title: Text(category.name,  style: Theme.of(context).textTheme.headlineMedium),
      subtitle: Text(categoryProducts.isEmpty ? t(context).withoutProduct : "${toPersianNumber(context, categoryProducts.length.toString())} ${t(context).product}", style: Theme.of(context).textTheme.headlineSmall),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.primary.withOpacity(.5)),
        onPressed: () => _removeCategoryHandler(context),
      ),
      onTap: () => _redirectCategoryToEditForm(context),
    );
  }
}
