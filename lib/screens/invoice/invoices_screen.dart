import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/states/global_search_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/invoice/invoicesScreen/invoice_bottom_navigation_bar_widget.dart';
import 'package:invoice/widgets/invoice/invoicesScreen/invoice_main_app_bar_widget.dart';
import 'package:invoice/widgets/invoice/invoicesScreen/invoice_search_app_bar_widget.dart';
import 'package:invoice/widgets/invoice/invoicesScreen/invoice_list_widget.dart';
import 'package:invoice/widgets/global/scroll/scroll_top_widget.dart';

class InvoicesScreen extends StatelessWidget {
  
  const InvoicesScreen({super.key});

  Future<bool> _willPopScopeHandler(BuildContext context) {
    GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);
    InvoiceState invoiceState = getInvoiceState(context, listen: false);

    if(invoiceState.selectedInvoices.isNotEmpty) {
      invoiceState.removeSelectedInvoices();
      return Future.value(false);
    }

    if(globalSearchState.appBarType == AppBarType.mainAppBar) {
      return Future.value(true);
    } else {
      invoiceState.addInvoices(invoiceState.tempInvoices);
      globalSearchState.setAppBarType(AppBarType.mainAppBar);
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelectedInvoice = getInvoiceState(context).selectedInvoices.isNotEmpty;
    GlobalSearchState globalSearchState = getGlobalSearchState(context);

    return WillPopScope(
      onWillPop: () => _willPopScopeHandler(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: {
          'mainAppBar': const InvoiceMainAppBarWidget(),
          'searchAppBar': const InvoiceSearchAppBarWidget()
        }[globalSearchState.appBarType.name],
        body: const InvoiceListWidget(),
        bottomNavigationBar: isSelectedInvoice ? const InvoiceBottomNavigationBarWidget() : null,
        floatingActionButton: ScrollTopWidget(getInvoiceState(context, listen: false).invoiceScrollController),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      )
    );
  }
}
