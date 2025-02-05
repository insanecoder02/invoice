import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/global/bottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:invoice/widgets/global/bottomNavigationBar/bottom_navigation_bar_item_widget.dart';
import 'package:invoice/functions/core_function.dart' show t, showDialogWidget, navigatorByPop, showSnackBarWidget;

class CustomerInvoicesBottomNavigationBarWidget extends StatelessWidget {

  const CustomerInvoicesBottomNavigationBarWidget({super.key});

  void _removeSelectedInvoicesHandler(BuildContext context) {
    showDialogWidget(context,
      content: Text(t(context).areYouSure(t(context).delete)),
      actions: [
          TextButton(
            child: Text(t(context).cancel),
            onPressed: () => navigatorByPop(context, result: false),
          ),
          const SizedBox(width: 20.0),
          TextButton(
            child: Text(t(context).removeForever),
            onPressed: () => navigatorByPop(context, result: true),
          )
        ]
    ).then((result) {
      if(result) {
        InvoiceState invoiceState = getInvoiceState(context, listen: false);
        CustomerInvoicesState customerInvoiceState = getCustomerInvoicesState(context, listen: false);
        InvoicesTableSqliteDatabase().removeGroup(customerInvoiceState.selectedCustomerInvoices).then((int count) {
          invoiceState.removeInvoices(invoices: customerInvoiceState.selectedCustomerInvoices);
          customerInvoiceState.removeCustomerInvoices();
        }).catchError((error) {
          showSnackBarWidget(context, content: Text(t(context).dbError));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarWidget(
      items: [
        BottomNavigationBarItemWidget(
          icon: const Icon(Icons.delete_outline),
          label: t(context).delete,
          onPressed: () => _removeSelectedInvoicesHandler(context),
        )
      ]
    );
  }
}
