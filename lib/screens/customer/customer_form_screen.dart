import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/customers_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget, navigatorByPop, navigatorByPushReplacementNamed;
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/widgets/customer/customerFormScreen/customer_text_form_fields_widget.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/states/customer_state.dart';

class CustomerFormScreen extends StatefulWidget {

  const CustomerFormScreen({super.key});

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _existsError;

  bool _isLoading = false;

  void _showSnackBarErrorForm() => showSnackBarWidget(context, content: Text(t(context).formError), duration: const Duration(seconds: 3));

  void _onProcessForm() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if(_formKey.currentState!.validate()) {

      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      getGlobalFormState(context, listen: false).isCreateForm
       ? _customerCreate() 
       : _updateCustomer();

    } else {
      _showSnackBarErrorForm();
    }
  }

  dynamic _customerCreate() async {
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;
    CustomerState customerState = getCustomerState(context, listen: false);

    List<CustomerModel> result = customerState.customers.where((CustomerModel customer) => customer.nationalCode == formData['nationalCode']).toList();

    if(result.isNotEmpty) {
      setState(() => _existsError = t(context).alreadyExisted(t(context).nationalCode));
      setState(() => _isLoading = false);
      return _showSnackBarErrorForm();
    }

    formData['createdAt'] = formData['updatedAt'] = formData['seenAt'] = DateTime.now().toString();

    CustomersTableSqliteDatabase().create(CustomerModel.fromJson(formData))
      .then((int id) {
        setState(() => _isLoading = false);
        CustomerModel customerModel = CustomerModel.fromJson({...formData, 'id': id});
        getCustomerState(context, listen: false).addCustomer(customerModel);
        getCustomerInvoicesState(context, listen: false).setCustomer(customerModel);
        navigatorByPushReplacementNamed(context, "/customer/invoices");
      }).catchError((error) => _errorHandler(error));
  }

  dynamic _updateCustomer() {
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;
    CustomerState customerState = getCustomerState(context, listen: false);

    List<CustomerModel> result = customerState.customers.where((CustomerModel customer) => customer.nationalCode == formData['nationalCode'] && customer.id != formData['id']).toList();

    if(result.isNotEmpty) {
      setState(() => _existsError = t(context).alreadyExisted(t(context).nationalCode));
      setState(() => _isLoading = false);
      return _showSnackBarErrorForm();
    }

    formData['updatedAt'] = formData['seenAt'] = DateTime.now().toString();

    CustomersTableSqliteDatabase().update(CustomerModel.fromJson(formData))
      .then((int id) {
        setState(() => _isLoading = false);
        CustomerModel customerModel = CustomerModel.fromJson(formData);
        customerState.updateCustomer(customerModel);
        getCustomerInvoicesState(context, listen: false).updateCustomer(customerModel);
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
          title: Text(globalFormState.isCreateForm ? t(context).customerCreate : t(context).customerEdit, style: Theme.of(context).textTheme.headlineLarge),
          actions: [
            IconButton(
              icon: const Icon(Icons.check, size: 30.0),
              onPressed: !_isLoading ? _onProcessForm : null,
            ),
            const SizedBox(width: 10.0)
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          physics: const ClampingScrollPhysics(),
          children: [
            Form(
              key: _formKey,
              child: CustomerTextFormFieldsWidget(_existsError),
            )
          ],
        )
      ),
    );
  }
}
