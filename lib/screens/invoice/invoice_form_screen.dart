import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget, navigatorByPop, navigatorByPushReplacementNamed, toPersianNumber;
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/widgets/invoice/invoiceFormScreen/invoice_text_form_fields_widget.dart';
import 'package:invoice/widgets/invoice/invoiceFormScreen/invoice_switch_type_widget.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/invoice_state.dart';

class InvoiceFormScreen extends StatefulWidget {

  final ScrollController? scrollController;

  const InvoiceFormScreen({super.key, this.scrollController});

  @override
  State<InvoiceFormScreen> createState() => _InvoiceFormScreenState();
}

class _InvoiceFormScreenState extends State<InvoiceFormScreen> {

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  void _onProcessForm() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if(_formKey.currentState!.validate()) {

      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      getGlobalFormState(context, listen: false).isCreateForm
       ? _invoiceCreate() 
       : _updateInvoice();

    } else {
      showSnackBarWidget(context, content: Text(t(context).formError), duration: const Duration(seconds: 3));
    }
  }

  void _invoiceCreate() async {
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;
    formData['customerId'] = getCustomerInvoicesState(context, listen: false).customer.id;
    formData['cashDiscount'] = formData['cashDiscount'].isNotEmpty ? formData['cashDiscount'] : 0;
    formData['volumeDiscount'] = formData['volumeDiscount'].isNotEmpty ? formData['volumeDiscount'] : 0;
    formData['createdAt'] = formData['updatedAt'] = DateTime.now().toString();

    InvoicesTableSqliteDatabase().create(InvoiceModel.fromJson(formData))
      .then((int id) {
        setState(() => _isLoading = false);
        InvoiceModel invoiceModel = InvoiceModel.fromJson({...formData, 'id': id});
        getInvoiceState(context, listen: false).addInvoice(invoiceModel);
        getCustomerInvoicesState(context, listen: false).addCustomerInvoice(invoiceModel);
        InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
        invoiceProductsState.setInvoiceModel(invoiceModel);
        invoiceProductsState.setTotalPrice(0);
        navigatorByPop(context);
        navigatorByPushReplacementNamed(context, "/invoice/products");
      }).catchError((error) => _errorHandler(error));
  }

  void _updateInvoice() {
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;
    formData['cashDiscount'] = formData['cashDiscount'].isNotEmpty ? formData['cashDiscount'] : 0;
    formData['volumeDiscount'] = formData['volumeDiscount'].isNotEmpty ? formData['volumeDiscount'] : 0;
    formData['updatedAt'] = DateTime.now().toString();

    InvoicesTableSqliteDatabase().update(InvoiceModel.fromJson(formData))
      .then((int id) {
        setState(() => _isLoading = false);
        InvoiceModel invoiceModel = InvoiceModel.fromJson(formData);
        getInvoiceState(context, listen: false).updateInvoice(invoiceModel);
        getInvoiceProductsState(context, listen: false).updateInvoice(invoiceModel);
        getCustomerInvoicesState(context, listen: false).updateCustomerInvoice(invoiceModel);
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(globalFormState.isCreateForm ? t(context).invoiceCreate : t(context).edit, style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(width: 10.0),
                  
                  if(!globalFormState.isCreateForm)
                  Expanded(child: Text("${(getInvoiceProductsState(context).invoice.getType ? t(context).invoice : t(context).preinvoice)} ${toPersianNumber(context, (getInvoiceProductsState(context).invoice.id!.toInt() + Config.baseInvoiceNumber).toString(), onlyConvert: true)}", style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.ellipsis))
                ],
              ),

              if(!globalFormState.isCreateForm)
              FittedBox(
                fit: BoxFit.cover,
                child: Text(getCustomerInvoicesState(context).customer.name, style: Theme.of(context).textTheme.headlineSmall),
              )
            ]
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check, size: 30.0),
              onPressed: !_isLoading ? _onProcessForm : null,
            ),
            const SizedBox(width: 10.0)
          ],
        ),
        body: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Form(
              key: _formKey,
              child: const Column(
                children: [
                  InvoiceTextFormFieldsWidget(),
                  InvoiceSwitchTypeWidget(),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
