import 'package:flutter/material.dart';
import 'package:invoice/widgets/invoiceProducts/invoiceProductsScreen/invoice_products_app_bar_widget.dart';
import 'package:invoice/widgets/invoiceProducts/invoiceProductsScreen/invoice_products_information_widget.dart';
import 'package:invoice/widgets/invoiceProducts/invoiceProductsScreen/invoice_products_list_widget.dart';
import 'package:invoice/widgets/invoiceProducts/invoiceProductsScreen/invoice_products_floating_action_button_widget.dart';

class InvoiceProductsScreen extends StatelessWidget {
  
  final bool redirectToCustomerInvoicesEnable;

  const InvoiceProductsScreen({
    super.key,
    this.redirectToCustomerInvoicesEnable = true
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: InvoiceProductsAppBarWidget(redirectToCustomerInvoicesEnable: redirectToCustomerInvoicesEnable),
        body: const Column(
          children: [
            InvoiceProductsInformationWidget(),
            InvoiceProductsListWidget()
          ],
        ),
        floatingActionButton: const InvoiceProductsFloatingActionButtonWidget(),
      ),
    );
  }
}
