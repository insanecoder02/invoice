import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/global/progresses/progress_full_screen_widget.dart';
import 'package:invoice/widgets/home/homeScreen/home_latest_invoice_item_widget.dart';

class HomeLatestInvoiceListWidget extends StatefulWidget {

  const HomeLatestInvoiceListWidget({super.key});

  @override
  State<HomeLatestInvoiceListWidget> createState() => _HomeLatestInvoiceListWidgetState();
}

class _HomeLatestInvoiceListWidgetState extends State<HomeLatestInvoiceListWidget> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  void _onChangeIsLoding(bool value) => setState(() => _isLoading = value);

  _initialData() {
    InvoiceState invoiceState = getInvoiceState(context, listen: false);
    if(invoiceState.invoices.isEmpty) {
      _onChangeIsLoding(true);
      InvoicesTableSqliteDatabase().all().then((List<InvoiceModel> invoices) {
        invoiceState.addInvoices(invoices);
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
  }

  @override
  Widget build(BuildContext context) {
    List<InvoiceModel> latestInvoices = getInvoiceState(context).invoices.take(10).toList();

    return ! _isLoading
      ? latestInvoices.isNotEmpty
        ? ListView(
            controller: getInvoiceState(context).homeScrollController,
            physics: const ScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                alignment: Alignment.center,
                child: Text(t(context).latestInvoices, style: Theme.of(context).textTheme.headlineSmall),
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: latestInvoices.length,
                itemBuilder: (context, index) => HomeLatestInvoiceItemWidget(latestInvoices[index]),
              )
            ],
          )
        : CenterMessageWidget(message: t(context).noInvoices, subMessage: t(context).tapAddInvoice)
      : const ProgressFullScreenWidget.center();
  }
}
