import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/categories_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/models/category_model.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/widgets/category/categoriesScreen/category_item_widget.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/global/progresses/progress_full_screen_widget.dart';

class CategoryListWidget extends StatefulWidget {
  
  const CategoryListWidget({super.key});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  void _onChangeIsLoding(bool value) => setState(() => _isLoading = value);

  _initialData() {
    CategoryState categoryState = getCategoryState(context, listen: false);
    if(categoryState.categories.isEmpty) {
      _onChangeIsLoding(true);
      CategoriesTableSqliteDatabase().all().then((List<CategoryModel> categories) {
        categoryState.addCategories(categories);
        _onChangeIsLoding(false);
      }).catchError((error) {
        _onChangeIsLoding(false);
        showSnackBarWidget(
          context,
          content: Text(t(context).fetchDataError),
          actionLabel: t(context).tryAgain,
          onPressed: _initialData
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoryState categoryState = getCategoryState(context);

    return ! _isLoading
      ? categoryState.categories.isNotEmpty
        ? ListView.builder(
            controller: categoryState.scrollController,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryState.categories.length,
            itemBuilder: (context, index) => CategoryItemWidget(index, categoryState.categories[index]),
          )
        : CenterMessageWidget(message: t(context).noCategories, subMessage: t(context).tapAddCategories)
      : const ProgressFullScreenWidget.center();
  }
}
