import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/models/invoice_product_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/product_state.dart';

class InvoiceProductsState extends ChangeNotifier {

  late InvoiceModel _invoice;

  final List<InvoiceProductModel> _invoiceProducts = [];

  final List<InvoiceProductModel> _selectedInvoiceProducts = [];
  
  final ScrollController scrollController = ScrollController();

  int _totalPrice = 0;

  InvoiceModel get invoice => _invoice;

  UnmodifiableListView<InvoiceProductModel> get invoiceProducts => UnmodifiableListView(_invoiceProducts);

  UnmodifiableListView<InvoiceProductModel> get selectedInvoices => UnmodifiableListView(_selectedInvoiceProducts);

  int get totalPrice => _totalPrice;

  void _changeTotal(BuildContext context, InvoiceProductModel invoiceProduct, {Operator operator = Operator.plus}) {
    List<ProductModel> products = getProductState(context, listen: false).products;
    ProductModel product = products.where((ProductModel product) => product.id == invoiceProduct.productId).first;
    operator == Operator.plus ? _totalPrice += invoiceProduct.productPriceEach * (product.quantityInBox * invoiceProduct.quantityOfBoxes) : _totalPrice -= invoiceProduct.productPriceEach * (product.quantityInBox * invoiceProduct.quantityOfBoxes);
  }

  setTotalPrice(int value) {
    _totalPrice = value;
    notifyListeners();
  }

  setInvoiceModel(InvoiceModel invoice) {
    _invoice = invoice;
    notifyListeners();
  }

  void updateInvoice(InvoiceModel invoice) {
    _invoice = invoice;
    notifyListeners();
  }

  void addInvoiceProduct(BuildContext context, InvoiceProductModel invoiceProduct) {
    _invoiceProducts.insert(0, invoiceProduct);
    _changeTotal(context, invoiceProduct);
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    notifyListeners();
  }

  void addInvoiceProducts(BuildContext context, List<InvoiceProductModel> invoiceProducts) {
    _invoiceProducts.clear();
    _invoiceProducts.addAll(invoiceProducts);
    invoiceProducts.toList().forEach((InvoiceProductModel item) => _changeTotal(context, item));
    removeSelectedInvoiceProducts();
    notifyListeners();
  }

    void updateInvoiceProduct(BuildContext context, InvoiceProductModel invoiceProduct) {
    int index = _invoiceProducts.indexWhere((InvoiceProductModel item) => item.id == invoiceProduct.id);
    _changeTotal(context, _invoiceProducts[index], operator: Operator.minus);
    _changeTotal(context, invoiceProduct, operator: Operator.plus);
    _invoiceProducts[index] = invoiceProduct;
    notifyListeners();
  }

  void addselectedInvoiceProduct(InvoiceProductModel invoiceProduct) {
    _selectedInvoiceProducts.add(invoiceProduct);
    notifyListeners();
  }

  void addselectedInvoiceProducts() {
    _selectedInvoiceProducts.clear();
    _selectedInvoiceProducts.addAll(_invoiceProducts);
    notifyListeners();
  }

  void removeInvoiceProduct(BuildContext context, InvoiceProductModel invoiceProduct) {
    _invoiceProducts.remove(invoiceProduct);
    _changeTotal(context, invoiceProduct, operator: Operator.minus);
    notifyListeners();
  }

  void removeInvoiceProducts(BuildContext context) {
    invoiceProducts.toList().forEach((InvoiceProductModel item) => _changeTotal(context, item, operator: Operator.minus));
    _invoiceProducts.removeWhere((f) => _selectedInvoiceProducts.contains(f));
    _selectedInvoiceProducts.clear();
    notifyListeners();
  }

  void removeSelectedInvoiceProduct(BuildContext context, InvoiceProductModel invoiceProduct) {
    _selectedInvoiceProducts.remove(invoiceProduct);
    _changeTotal(context, invoiceProduct, operator: Operator.minus);
    notifyListeners();
  }

  void removeSelectedInvoiceProducts() {
    _selectedInvoiceProducts.clear();
    notifyListeners();
  }
}

InvoiceProductsState getInvoiceProductsState(BuildContext context, {bool listen = true}) => Provider.of<InvoiceProductsState>(context, listen: listen);
