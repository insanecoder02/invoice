import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/global_search_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/global/bottomNavigationBar/bottom_navigation_bar_widget.dart';
import 'package:invoice/widgets/global/bottomNavigationBar/bottom_navigation_bar_item_widget.dart';
import 'package:invoice/functions/core_function.dart' show t, showDialogWidget, navigatorByPop;
import 'package:persian_number_utility/persian_number_utility.dart';

class InvoiceBottomNavigationBarWidget extends StatelessWidget {

  const InvoiceBottomNavigationBarWidget({super.key});

  List<Map> _convertModelListTOMapListForInvoices(BuildContext context) {
    List<CustomerModel> customers = getCustomerState(context, listen: false).customers;
    return getInvoiceState(context, listen: false).invoices.map((InvoiceModel invoice) {

      String invoiceNumber = (invoice.id!.toInt() + Config.baseInvoiceNumber).toString();
      String invoiceType = invoice.getType ? t(context).invoice : t(context).preinvoice;
      CustomerModel customer = customers.where((CustomerModel item) => item.id == invoice.customerId ).first;
      
      return {
        ...invoice.toMap(),
        "invoiceNumber": invoiceNumber,
        "invoiceType": invoiceType,
        "name": customer.name.toLowerCase(),
        "phone": customer.phone.toLowerCase(),
        "address": customer.address.toLowerCase(),
        "invoice": invoice
      };

    }).toList();
  }

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
          GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);
          if(globalSearchState.appBarType == AppBarType.searchAppBar) {
            List<Map> invoicesMap = _convertModelListTOMapListForInvoices(context);
            String value = globalSearchState.searchValue.toEnglishDigit().toLowerCase();

            List<InvoiceModel> invoices = [];
            invoicesMap.toList().forEach((Map invoice) {
              if( invoice['invoiceNumber'].contains(value) ||
                  invoice['invoiceType'] == value
              ) {
                invoices.add(invoice['invoice']);
              }
            });

            invoiceState.addInvoices(invoices);
          }
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
