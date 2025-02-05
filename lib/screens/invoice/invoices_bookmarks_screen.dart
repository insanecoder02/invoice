import 'package:flutter/material.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/global/scroll/scroll_top_widget.dart';
import 'package:invoice/widgets/invoice/invoicesBookmarksScreen/invoices_bookmarks_app_bar_widget.dart';
import 'package:invoice/widgets/invoice/invoicesBookmarksScreen/invoices_bookmarks_list_widget.dart';

class InvoicesBookmarksScreen extends StatelessWidget {

  const InvoicesBookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InvoicesBookmarksAppBarWidget(),
      body: const InvoicesBookmarksListWidget(),
      floatingActionButton: ScrollTopWidget(getInvoiceState(context, listen: true).invoiceScrollController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
