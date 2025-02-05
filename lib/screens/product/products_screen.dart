import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/states/global_search_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/widgets/product/productsScreen/product_List_widget.dart';
import 'package:invoice/widgets/product/productsScreen/product_main_app_bar_widget.dart';
import 'package:invoice/widgets/product/productsScreen/product_search_app_bar_widget.dart';
import 'package:invoice/widgets/global/scroll/scroll_top_widget.dart';

class ProductsScreen extends StatelessWidget {
  
  const ProductsScreen({super.key});

  Future<bool> _willPopScopeHandler(BuildContext context) async {
    GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);

    if(globalSearchState.appBarType == AppBarType.mainAppBar) {
      return Future.value(true);
    } else {
      ProductState productState = getProductState(context, listen: false);
      productState.addProducts(productState.tempProducts);
      globalSearchState.setAppBarType(AppBarType.mainAppBar);
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalSearchState globalSearchState = getGlobalSearchState(context);

    return WillPopScope(
      onWillPop: () => _willPopScopeHandler(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: {
          'mainAppBar': const ProductMainAppBarWidget(),
          'searchAppBar': const ProductSearchAppBarWidget()
        }[globalSearchState.appBarType.name],
        body: const ProductListWidget(),
        floatingActionButton: ScrollTopWidget(getProductState(context, listen: false).scrollController),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      )
    );
  }
}
