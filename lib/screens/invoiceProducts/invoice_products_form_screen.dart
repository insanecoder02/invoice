import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/invoice_products_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPop, showSnackBarWidget;
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/models/invoice_product_model.dart';
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/widgets/invoiceProducts/invoiceProductsFormScreen/invoice_products_text_form_fields_widget.dart';

class InvoiceProductsFormScreen extends StatefulWidget {

  const InvoiceProductsFormScreen({super.key});

  @override
  State<InvoiceProductsFormScreen> createState() => _InvoiceProductsFormScreenState();
}

class _InvoiceProductsFormScreenState extends State<InvoiceProductsFormScreen> {

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String? _existsError;

  void _showSnackBarErrorForm() => showSnackBarWidget(context, content: Text(t(context).formError), duration: const Duration(seconds: 3));

  void _onProcessForm() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if(_formKey.currentState!.validate()) {

      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      getGlobalFormState(context, listen: false).isCreateForm
       ? _invoiceCreateProducts() 
       : _updateInvoiceProducts();

    } else {
      _showSnackBarErrorForm();
    }
  }

  dynamic _invoiceCreateProducts() async {
    InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
    List<ProductModel> products = getProductState(context, listen: false).products;
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;

    if (products.where((ProductModel product) => product.code == formData['productCode']).isEmpty) {
      setState(() => _existsError = t(context).noProduct);
      setState(() => _isLoading = false);
      return _showSnackBarErrorForm();
    }

    if (invoiceProductsState.invoiceProducts.where((InvoiceProductModel invoiceProduct) => invoiceProduct.productId == formData['productId']).isNotEmpty) {
      setState(() => _existsError = t(context).alreadyExisted(t(context).product));
      setState(() => _isLoading = false);
      return _showSnackBarErrorForm();
    }

    formData["invoiceId"] = invoiceProductsState.invoice.id;

    InvoiceProductsTableSqliteDatabase().create(InvoiceProductModel.fromJson(formData), invoiceProductsState.invoice.id!)
      .then((int id) {
        setState(() => _isLoading = false);
        InvoiceModel invoice = InvoiceModel.fromJson({...invoiceProductsState.invoice.toMap(), 'updatedAt': DateTime.now().toString()});
        getInvoiceState(context, listen: false).updateInvoice(invoice);
        getInvoiceProductsState(context, listen: false).updateInvoice(invoice);
        invoiceProductsState.addInvoiceProduct(context, InvoiceProductModel.fromJson({...formData, 'id': id}));
        navigatorByPop(context);
      }).catchError((error) => _errorHandler(error));
  }

  dynamic _updateInvoiceProducts() {
    InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
    List<ProductModel> products = getProductState(context, listen: false).products;
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;

    if (products.where((ProductModel product) => product.code == formData['productCode']).isEmpty) {
      setState(() => _existsError = t(context).noProduct);
      setState(() => _isLoading = false);
      return _showSnackBarErrorForm();
    }

    if (invoiceProductsState.invoiceProducts.where((InvoiceProductModel invoiceProduct) => invoiceProduct.productId == formData['productId'] && formData['productId'] != formData['currentProductId']).isNotEmpty) {
      setState(() => _existsError = t(context).alreadyExisted(t(context).product));
      setState(() => _isLoading = false);
      return _showSnackBarErrorForm();
    }

    formData["invoiceId"] = invoiceProductsState.invoice.id;

    InvoiceProductsTableSqliteDatabase().update(InvoiceProductModel.fromJson(formData), invoiceProductsState.invoice.id!)
      .then((int id) {
        setState(() => _isLoading = false);
        InvoiceModel invoice = InvoiceModel.fromJson({...invoiceProductsState.invoice.toMap(), 'updatedAt': DateTime.now().toString()});
        getInvoiceState(context, listen: false).updateInvoice(invoice);
        getInvoiceProductsState(context, listen: false).updateInvoice(invoice);
        invoiceProductsState.updateInvoiceProduct(context, InvoiceProductModel.fromJson(formData));
        navigatorByPop(context);
      }).catchError((error) => _errorHandler(error));
  }

  dynamic _errorHandler(dynamic error) {
    setState(() => _isLoading = false);
    showSnackBarWidget(context, content: Text(t(context).dbError));
  }

  @override
  Widget build(BuildContext context) {
    GlobalFormState globalFormState = getGlobalFormState(context);

    return WillPopScope(
      onWillPop: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(globalFormState.isCreateForm ? t(context).productCreate : t(context).productEdit, style: Theme.of(context).textTheme.headlineLarge),
          actions: [
            IconButton(
              icon: const Icon(Icons.check, size: 30.0),
              onPressed: !_isLoading ? _onProcessForm : null,
            ),
            const SizedBox(width: 10.0),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          physics: const ClampingScrollPhysics(),
          children: [
            Form(
              key: _formKey,
              child: InvoiceProductsTextFormFieldsWidget(_existsError),
            )
          ],
        )
      ),
    );
  }
}
