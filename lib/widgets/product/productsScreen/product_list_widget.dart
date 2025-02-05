import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/products_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/global/progresses/progress_full_screen_widget.dart';
import 'package:invoice/widgets/product/productsScreen/product_item_widget.dart';

class ProductListWidget extends StatefulWidget {

  const ProductListWidget({super.key});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  void _onChangeIsLoding(bool value) => setState(() => _isLoading = value);

  void _initialData() async {
    ProductState productState = getProductState(context, listen: false);
    if(productState.products.isEmpty) {
      _onChangeIsLoding(true);
      ProductsTableSqliteDatabase().all().then((List<ProductModel> products) {
        productState.addProducts(products, withTemp: true);
        _onChangeIsLoding(false);
        return Future.value();
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
    ProductState productState = getProductState(context);

    return ! _isLoading
      ? productState.products.isNotEmpty
        ? ListView.builder(
            controller: productState.scrollController,
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            itemCount: productState.products.length,
            itemBuilder: (context, index) => ProductItemWidget(productState.products[index], index),
          )
        : CenterMessageWidget(message: t(context).noProducts, subMessage: t(context).tapAddProducts)
      : const ProgressFullScreenWidget.center();
  }
}
