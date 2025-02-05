import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice/models/category_model.dart';

class CategoryState extends ChangeNotifier {
  
  final List<CategoryModel> _categories = [];
  
  final ScrollController scrollController = ScrollController();

  UnmodifiableListView<CategoryModel> get categories => UnmodifiableListView(_categories);

  void addCategory(CategoryModel category) {
    _categories.insert(0, category);
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    notifyListeners();
  }

  void addCategories(List<CategoryModel> categories) {
    _categories.clear();
    _categories.addAll(categories);
    notifyListeners();
  }

  void updateCategory(CategoryModel category) {
    _categories[_categories.indexWhere((CategoryModel item) => item.id == category.id)] = category;
    notifyListeners();
  }

  void removeCategory(CategoryModel category) {
    _categories.remove(category);
    notifyListeners();
  }
}

CategoryState getCategoryState(BuildContext context, {bool listen = true}) => Provider.of<CategoryState>(context, listen: listen);
