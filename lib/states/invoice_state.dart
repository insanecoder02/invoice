import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:provider/provider.dart';

class InvoiceState extends ChangeNotifier {
  
  final List<InvoiceModel> _invoices = [], _tempInvoices = [];

  final List<InvoiceModel> _selectedInvoices = [];

  final ScrollController homeScrollController = ScrollController();
  
  final ScrollController invoiceScrollController = ScrollController();

  UnmodifiableListView<InvoiceModel> get tempInvoices => UnmodifiableListView(_tempInvoices);

  UnmodifiableListView<InvoiceModel> get invoices => UnmodifiableListView(_invoices);

  UnmodifiableListView<InvoiceModel> get selectedInvoices => UnmodifiableListView(_selectedInvoices);

  void addInvoice(InvoiceModel invoice) {
    _invoices.insert(0, invoice);
    _tempInvoices.insert(0, invoice);
    if(homeScrollController.hasClients) {
      homeScrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    if(invoiceScrollController.hasClients) {
      invoiceScrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    notifyListeners();
  }

  void addInvoices(List<InvoiceModel> invoices, {bool withTemp = false}) {
    _invoices.clear();
    _invoices.addAll(invoices);
    removeSelectedInvoices();
    if(withTemp) {
      _tempInvoices.clear();
      _tempInvoices.addAll(invoices);
    }
    notifyListeners();
  }

  void updateInvoice(InvoiceModel invoice, {bool goToFirst = true}) {
    if(goToFirst) {
      _invoices.removeWhere((InvoiceModel item) => item.id == invoice.id);
      _tempInvoices.removeWhere((InvoiceModel item) => item.id == invoice.id);
      _invoices.insert(0, invoice);
      _tempInvoices.insert(0, invoice);
      if(homeScrollController.hasClients) {
        homeScrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
      }
      if(invoiceScrollController.hasClients) {
        invoiceScrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
      }
    } else {
      int invoiceIndex = _invoices.indexWhere((InvoiceModel item) => item.id == invoice.id);
      int tempInvoiceIndex = _invoices.indexWhere((InvoiceModel item) => item.id == invoice.id);
      _invoices[invoiceIndex] = invoice;
      _tempInvoices[tempInvoiceIndex] = invoice;
    }
    notifyListeners();
  }

  void addSelectedInvoice(InvoiceModel invoice) {
    _selectedInvoices.add(invoice);
    notifyListeners();
  }

  void addSelectedInvoices({int? take, List<InvoiceModel>? customInvoices}) {
    _selectedInvoices.clear();
    if(take != null) {
      _selectedInvoices.addAll(_invoices.take(take));
    } else if(customInvoices != null) {
      _selectedInvoices.addAll(customInvoices);
    } else {
      _selectedInvoices.addAll(_invoices);
    }
    notifyListeners();
  }

  void removeInvoice(InvoiceModel invoice) {
    _invoices.removeWhere((InvoiceModel item) => item.id == invoice.id);
    _tempInvoices.removeWhere((InvoiceModel item) => item.id == invoice.id);
    notifyListeners();
  }

  void removeInvoices({List<InvoiceModel>? invoices}) {
    if(invoices == null) {
      _invoices.removeWhere((invoice) => _selectedInvoices.contains(invoice));
      _tempInvoices.removeWhere((invoice) => _selectedInvoices.contains(invoice));
      _selectedInvoices.clear();
    } else {
      invoices.toList().forEach((InvoiceModel invoice) => _invoices.removeWhere((item) => item.id == invoice.id));
      invoices.toList().forEach((InvoiceModel invoice) => _tempInvoices.removeWhere((item) => item.id == invoice.id));
    }
    notifyListeners();
  }

  void removeCustomerInvoices(int customerId) {
    _invoices.removeWhere((invoice) => invoice.customerId == customerId);
    notifyListeners();
  }

  void removeSelectedInvoice(InvoiceModel invoice) {
    _selectedInvoices.remove(invoice);
    notifyListeners();
  }

  void removeSelectedInvoices() {
    _selectedInvoices.clear();
    notifyListeners();
  }
}

InvoiceState getInvoiceState(BuildContext context, {bool listen = true}) => Provider.of<InvoiceState>(context, listen: listen);
