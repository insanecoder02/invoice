import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/models/category_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/widgets/product/productSearchScreen/product_search_item_widget.dart';
import 'package:invoice/widgets/global/form/search_box_widget.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/global/scroll/scroll_top_widget.dart';

class ProductSearchScreen extends StatefulWidget {
  
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {

  List<Map> productsMap = [];

  List<Map<String, ProductModel>> products = [];

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _convertModelListTOMapListForProducts();
  }

  void _convertModelListTOMapListForProducts() {
    ProductState productState = getProductState(context, listen: false);
    List<CategoryModel> categories = getCategoryState(context, listen: false).categories;
    productsMap = productState.products.map((product) {
      String categoryName = categories.where((CategoryModel category) => category.id == product.categoryId).first.name;
      return {
        "code": product.code,
        "name": "${categoryName.toLowerCase()} ${product.name.toLowerCase()}",
        "productWithCategory": ProductModel.fromJson({...product.toMap(), "name": "$categoryName ${product.name}"}),
        "productOriginal": product
      };
    }).toList();
    _searchProductHandler('');
  }

  void _searchProductHandler(String value) {
    value = value.toEnglishDigit().toLowerCase();

    products.clear();
    productsMap.toList().forEach((Map product) {
      if( product["name"].toString().contains(value) ||
          product["code"].toString().contains(value)
      ) {
        products.add({
          "productWithCategory": product["productWithCategory"],
          "productOriginal": product["productOriginal"],
        });
      }
    });

    setState(() {});

    ScrollController scrollController = getProductState(context, listen: false).scrollController;
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
  }

  void _onCloseHandler() {
    _searchProductHandler('');
    ProductState productState = getProductState(context, listen: false);
    if(productState.scrollController.hasClients) {
      productState.scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 65.0,
        title: SearchBoxWidget(focusNode: focusNode, onChange: _searchProductHandler, onClose: _onCloseHandler),
        actions: const [
          SizedBox(width: 20.0)
        ],
      ),
      body: products.isNotEmpty
        ? ListView.builder(
            controller: getProductState(context).scrollController,
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: products.length,
            itemBuilder: (context, index) => ProductSearchItemWidget(products[index], index)
          )
        : CenterMessageWidget(message: t(context).noResultsFound),
      floatingActionButton: ScrollTopWidget(getProductState(context, listen: false).scrollController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
