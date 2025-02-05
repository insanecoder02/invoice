import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/widgets/global/progresses/progress_full_screen_widget.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/customer/customerInvoicesScreen/customer_invoices_item_widget.dart';

class CustomerInvoicesListWidget extends StatefulWidget {

  const CustomerInvoicesListWidget({super.key});

  @override
  State<CustomerInvoicesListWidget> createState() => _CustomerInvoicesListWidgetState();
}

class _CustomerInvoicesListWidgetState extends State<CustomerInvoicesListWidget> {

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  void _onChangeIsLoding(bool value) => setState(() => _isLoading = value);

  _initialData() {
    _onChangeIsLoding(true);
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context, listen: false);
    InvoicesTableSqliteDatabase().allInvoicesForOneCustomer(customerInvoicesState.customer.id ?? 0).then((List<InvoiceModel> invoices) {
      customerInvoicesState.addCustomerInvoices(invoices);
      _onChangeIsLoding(false);
    }).catchError((error) {
      _onChangeIsLoding(false);
      showSnackBarWidget(
        context,
        content: Text(t(context).fetchDataError),
        actionLabel: t(context).tryAgain,
        onPressed: _initialData
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context);

    return ! _isLoading
      ? customerInvoicesState.customerInvoices.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              controller: customerInvoicesState.scrollController,
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.only(top: 20.0),
              shrinkWrap: true,
              itemCount: customerInvoicesState.customerInvoices.length,  
              itemBuilder: (context, index) => CustomerInvoicesItemWidget(customerInvoicesState.customerInvoices[index], index),
            ),
          )
        : CenterMessageWidget(message: t(context).noInvoices, subMessage: t(context).tapAddInvoice, expanded: true)
      : const ProgressFullScreenWidget.center(expanded: true);
  }
}
