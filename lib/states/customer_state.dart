import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:provider/provider.dart';

class CustomerState extends ChangeNotifier {

  final List<CustomerModel> _customers = [], _tempCustomers = [];
  
  final ScrollController scrollController = ScrollController();

  UnmodifiableListView<CustomerModel> get customers => UnmodifiableListView(_customers);

  UnmodifiableListView<CustomerModel> get tempCustomers => UnmodifiableListView(_tempCustomers);

  void addCustomer(CustomerModel customer) {
    _customers.insert(0, customer);
    _tempCustomers.insert(0, customer);
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    notifyListeners();
  }

  void addCustomers(List<CustomerModel> customers,  {bool withTemp = false}) {
    _customers.clear();
    _customers.addAll(customers);
    if(withTemp) {
      _tempCustomers.clear();
      _tempCustomers.addAll(customers);
    }
    notifyListeners();
  }

  void updateCustomer(CustomerModel customer) {
    _customers.removeWhere((CustomerModel item) => item.id == customer.id);
    _customers.insert(0, customer);
    _tempCustomers.removeWhere((CustomerModel item) => item.id == customer.id);
    _tempCustomers.insert(0, customer);
    notifyListeners();
  }

  void removeCustomer(CustomerModel customer) {
    _customers.removeWhere((CustomerModel item) => item.id == customer.id);
    _tempCustomers.removeWhere((CustomerModel item) => item.id == customer.id);
    notifyListeners();
  }
}

CustomerState getCustomerState(BuildContext context, {bool listen = true}) => Provider.of<CustomerState>(context, listen: listen);
