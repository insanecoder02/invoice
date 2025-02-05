import 'package:flutter/material.dart';
import 'package:invoice/models/category_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/widgets/global/form/search_box_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ProductSearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget{

  const ProductSearchAppBarWidget({super.key});

  @override
  State<ProductSearchAppBarWidget> createState() => _ProductSearchAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _ProductSearchAppBarWidgetState extends State<ProductSearchAppBarWidget> {

  final FocusNode focusNode = FocusNode();

  List<Map> productsMap = [];

  @override
  void initState() {
    super.initState();
    _convertModelListTOMapListForProducts();
  }

  void _convertModelListTOMapListForProducts() {
    ProductState productState = getProductState(context, listen: false);
    List<CategoryModel> categories = getCategoryState(context, listen: false).categories;
    productsMap = productState.products.map((product) => {...product.toMap(), "name": "${categories.where((CategoryModel category) => category.id == product.categoryId).first.name.toLowerCase()} ${product.name.toLowerCase()}", "product": product}).toList();
  }

  void _searchProductsHandler(String value) {
    value = value.toEnglishDigit().toLowerCase();

    List<ProductModel> products = [];
    productsMap.toList().forEach((Map product) {
      if( product["name"].toString().contains(value) ||
          product["code"].toString().contains(value)
      ) {
        products.add(product["product"]);
      }
    });

    ProductState productState = getProductState(context, listen: false);
    productState.addProducts(products);
    ScrollController scrollController = productState.scrollController;
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
  }

  void _onCloseHandler() {
    ProductState productState = getProductState(context, listen: false);
    productState.addProducts(productState.tempProducts);
    ScrollController scrollController = productState.scrollController;
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    getProductState(context);
    
    return AppBar(
      titleSpacing: 0,
      title: SearchBoxWidget(focusNode: focusNode, onChange: _searchProductsHandler, onClose: _onCloseHandler),
      actions: const [SizedBox(width: 20.0)],
    );
  }
}
