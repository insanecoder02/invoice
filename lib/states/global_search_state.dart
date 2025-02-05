import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice/constans/enums.dart';

class GlobalSearchState extends ChangeNotifier {

  AppBarType _appBartype = AppBarType.mainAppBar;
  
  String _searchValue = '';

  AppBarType get appBarType => _appBartype;

  String get searchValue => _searchValue;

  void setSearchValue(String value) {
    _searchValue = value;
    notifyListeners();
  }

  void setAppBarType(AppBarType value) {
    _appBartype = value;
    notifyListeners();
  }
}

GlobalSearchState getGlobalSearchState(BuildContext context, {bool listen = true}) => Provider.of<GlobalSearchState>(context, listen: listen);
