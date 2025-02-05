import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/global/progresses/progress_full_screen_widget.dart';
import 'package:invoice/widgets/invoice/invoicesBookmarksScreen/invoices_bookmarks_item_widget.dart';

class InvoicesBookmarksListWidget extends StatefulWidget {

  const InvoicesBookmarksListWidget({super.key});

  @override
  State<InvoicesBookmarksListWidget> createState() => _InvoicesBookmarksListWidgetState();
}

class _InvoicesBookmarksListWidgetState extends State<InvoicesBookmarksListWidget> {

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
    List<InvoiceModel> invoicesBookmarks = invoiceState.invoices.where((InvoiceModel invoice) => invoice.getBookmark).toList();

    return ! _isLoading
      ? invoicesBookmarks.isNotEmpty
        ? ListView.builder(
            controller: invoiceState.invoiceScrollController,
            padding: const EdgeInsets.only(top: 7.0),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: invoicesBookmarks.length,
            itemBuilder: (context, index) => InvoicesBookmarksItemWidget(invoicesBookmarks[index]),
          )
        : CenterMessageWidget(message: t(context).noBookmark)
      : const ProgressFullScreenWidget.center();
  }
}
