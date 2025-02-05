import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/global/progresses/progress_full_screen_widget.dart';
import 'package:invoice/widgets/invoice/invoicesScreen/invoice_item_widget.dart';

class InvoiceListWidget extends StatefulWidget {

  const InvoiceListWidget({super.key});

  @override
  State<InvoiceListWidget> createState() => _InvoiceListWidgetState();
}

class _InvoiceListWidgetState extends State<InvoiceListWidget> {

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  void _onChangeIsLoding(bool value) => setState(() => _isLoading = value);

  void _initialData() async {
    InvoiceState invoiceState = getInvoiceState(context, listen: false);
    if(invoiceState.invoices.isEmpty) {
      _onChangeIsLoding(true);
      InvoicesTableSqliteDatabase().all().then((List<InvoiceModel> invoices) {
        invoiceState.addInvoices(invoices, withTemp: true);
        _onChangeIsLoding(false);
        return Future.value();
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
  }

  @override
  Widget build(BuildContext context) {
    InvoiceState invoiceState = getInvoiceState(context);

    return ! _isLoading
      ? invoiceState.invoices.isNotEmpty
        ? ListView.builder(
            controller: invoiceState.invoiceScrollController,
            padding: const EdgeInsets.only(top: 7.0),
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            itemCount: invoiceState.invoices.length,
            itemBuilder: (context, index) => InvoiceItemWidget(invoiceState.invoices[index]),
          )
        : CenterMessageWidget(message: t(context).noInvoices, subMessage: t(context).tapAddInvoice)
      : const ProgressFullScreenWidget.center();
  }
}
