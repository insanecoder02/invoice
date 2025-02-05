import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/models/invoice_model.dart';

class CustomerInvoicesState extends ChangeNotifier {

  late CustomerModel _customer;

  final List<InvoiceModel> _customerInvoices = [];

  final List<InvoiceModel> _selectedCustomerInvoices = [];
  
  final ScrollController scrollController = ScrollController();

  CustomerModel get customer => _customer;

  UnmodifiableListView<InvoiceModel> get customerInvoices => UnmodifiableListView(_customerInvoices);

  UnmodifiableListView<InvoiceModel> get selectedCustomerInvoices => UnmodifiableListView(_selectedCustomerInvoices);

  setCustomer(CustomerModel customer) {
    _customer = customer;
    notifyListeners();
  }

  void updateCustomer(CustomerModel customer) {
    _customer = customer;
    notifyListeners();
  }

  void addCustomerInvoice(InvoiceModel customerInvoice) {
    _customerInvoices.insert(0, customerInvoice);
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    notifyListeners();
  }

  void addCustomerInvoices(List<InvoiceModel> customerInvoices) {
    _customerInvoices.clear();
    _customerInvoices.addAll(customerInvoices);
    removeSelectedCustomerInvoices();
    notifyListeners();
  }

    void updateCustomerInvoice(InvoiceModel customerInvoice) {
    int index = _customerInvoices.indexWhere((InvoiceModel invoice) => invoice.id == customerInvoice.id);
    _customerInvoices[index] = customerInvoice;
    notifyListeners();
  }

  void addSelectedCustomerInvoice(InvoiceModel customerInvoice) {
    _selectedCustomerInvoices.add(customerInvoice);
    notifyListeners();
  }

  void addSelectedCustomerInvoices() {
    _selectedCustomerInvoices.clear();
    _selectedCustomerInvoices.addAll(_customerInvoices);
    notifyListeners();
  }

  void removeCustomerInvoice(InvoiceModel customerInvoice) {
    _customerInvoices.removeWhere((InvoiceModel item) => item.id == customerInvoice.id);
    notifyListeners();
  }

  void removeCustomerInvoices() {
    _customerInvoices.removeWhere((f) => _selectedCustomerInvoices.contains(f));
    _selectedCustomerInvoices.clear();
    notifyListeners();
  }

  void removeSelectedCustomerInvoice(InvoiceModel customerInvoice) {
    _selectedCustomerInvoices.remove(customerInvoice);
    notifyListeners();
  }

  void removeSelectedCustomerInvoices() {
    _selectedCustomerInvoices.clear();
    notifyListeners();
  }
}

CustomerInvoicesState getCustomerInvoicesState(BuildContext context, {bool listen = true}) => Provider.of<CustomerInvoicesState>(context, listen: listen);
