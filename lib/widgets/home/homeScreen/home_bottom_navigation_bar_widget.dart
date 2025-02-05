import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/global/bottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:invoice/widgets/global/bottomNavigationBar/bottom_navigation_bar_item_widget.dart';
import 'package:invoice/functions/core_function.dart' show t, showDialogWidget, navigatorByPop;

class HomeBottomNavigationBarWidget extends StatelessWidget {

  const HomeBottomNavigationBarWidget({super.key});

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
        InvoicesTableSqliteDatabase().removeGroup(invoiceState.selectedInvoices).then((int count) {
          invoiceState.removeInvoices();
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
