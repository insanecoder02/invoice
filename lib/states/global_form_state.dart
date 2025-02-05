import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice/constans/enums.dart';

class GlobalFormState extends ChangeNotifier {

  Map<String, dynamic> categoryInitialValues = {
    'name': ''
  };

  Map<String, dynamic> productInitialValues = {
    'categoryId': '',
    'code': '',
    'name': '',
    'volume': '',
    'unit': '',
    'quantityInBox': '',
    'price': ''
  };

  Map<String, dynamic> customerInitialValues = {
    'nationalCode': '',
    'name': '',
    'phone': '',
    'address': ''
  };

  Map<String, dynamic> invoiceInitialValues = {
    'customerId': '',
    'type': 0,
    'cashDiscount': '',
    'volumeDiscount': '',
    'description': '',
    'bookmark': 0
  };

  Map<String, dynamic> invoiceProductsInitialValues = {
    'invoiceId': '',
    'productId': '',
    'productVolumeEach': '',
    'quantityOfBoxes': '',
    'productPriceEach': ''
  };

  Map<String, dynamic> _formData = {};

  FormMode _formMode = FormMode.create;

  Map<String, dynamic> get formData => _formData;

  FormMode get formMode => _formMode;

  bool get isCreateForm => _formMode == FormMode.create;

  setFormMode(FormMode mode) {
    _formMode = mode;
    notifyListeners();
  }

  changeFormData(String field, dynamic value) {
    _formData[field] = value;
    notifyListeners();
  }

  setFormData(Map<String, dynamic> value) {
    _formData = value;
    notifyListeners();
  }
}

GlobalFormState getGlobalFormState(BuildContext context, {bool listen = true}) => Provider.of<GlobalFormState>(context, listen: listen);
