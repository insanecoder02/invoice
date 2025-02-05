import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice/models/product_model.dart';

class ProductState extends ChangeNotifier {
  
  final List<ProductModel> _products = [], _tempProducts = [];
  
  final ScrollController scrollController = ScrollController();

  UnmodifiableListView<ProductModel> get products => UnmodifiableListView(_products);

  UnmodifiableListView<ProductModel> get tempProducts => UnmodifiableListView(_tempProducts);

  void addProduct(ProductModel product) {
    _products.insert(0, product);
    _tempProducts.insert(0, product);
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    notifyListeners();
  }

  void addProducts(List<ProductModel> products, {bool withTemp = false}) {
    _products.clear();
    _products.addAll(products);
    if(withTemp) {
      _tempProducts.clear();
      _tempProducts.addAll(products);
    }
    notifyListeners();
  }

  void updateProduct(ProductModel product) {
    _products.removeWhere((ProductModel item) => item.id == product.id);
    _products.insert(0, product);
    _tempProducts.removeWhere((ProductModel item) => item.id == product.id);
    _tempProducts.insert(0, product);
    notifyListeners();
  }

  void removeProduct(BuildContext context, ProductModel product) {
    _products.removeWhere((ProductModel item) => item.id == product.id);
    _tempProducts.removeWhere((ProductModel item) => item.id == product.id);
    notifyListeners();
  }

  void removeCategoryProducts(int categoryId) {
    _products.removeWhere((product) => product.categoryId == categoryId);
    _tempProducts.removeWhere((product) => product.categoryId == categoryId);
    notifyListeners();
  }
}

ProductState getProductState(BuildContext context, {bool listen = true}) => Provider.of<ProductState>(context, listen: listen);
