import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/config.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, showDialogWidget, navigatorByPop, navigatorByPushNamed, toPersianNumber;
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/global/cards/invoice_card_widget.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/customer_state.dart';

class InvoicesBookmarksItemWidget extends StatelessWidget {
  
  final InvoiceModel invoice;

  const InvoicesBookmarksItemWidget(this.invoice, {super.key});

  void _onToggleBookmark(BuildContext context) {
    showDialogWidget(context,
      content: Text(t(context).areYouSure('${t(context).delete.toLowerCase()} ${t(context).bookmark.toLowerCase()}')),
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
    ).then((bool result) {
      if(result) {
        invoice.bookmark = 0;
        InvoicesTableSqliteDatabase().update(invoice).then((int count) {
          getInvoiceState(context, listen: false).updateInvoice(invoice, goToFirst: false);
        });
      }
    });
  }

  void _redirectToInvoiceProducts(BuildContext context) {
    InvoiceState invoiceState = getInvoiceState(context, listen: false);
    InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
    invoiceProductsState.setInvoiceModel(invoice);
    invoiceProductsState.setTotalPrice(0);
    List<CustomerModel> customers = getCustomerState(context, listen: false).customers;
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context, listen: false);
    CustomerModel customer = customers.where((customer) => customer.id == invoice.customerId).first;
    customerInvoicesState.setCustomer(customer);
    customerInvoicesState.addCustomerInvoices(invoiceState.invoices.where((invoice) => invoice.customerId == customer.id).toList());
    navigatorByPushNamed(context, '/invoice/products');
  }
  
  @override
  Widget build(BuildContext context) {
    List<CustomerModel> customers = getCustomerState(context).customers;

    return InvoiceCardWidget(
      title: Text(customers.where((CustomerModel customer) => customer.id == invoice.customerId).first.name, style: Theme.of(context).textTheme.headlineMedium),
      subtitle: Row(
        children: [
          Text(invoice.getType ? t(context).invoice : t(context).preinvoice, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(width: 10),
          Text(toPersianNumber(context, (invoice.id!.toInt() + Config.baseInvoiceNumber).toString(), onlyConvert: true), style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text(
          isRTL(context)
            ? DateTime.parse(invoice.updatedAt ?? DateTime.now().toString()).toPersianDateStr()
            : DateFormat("dd MMM y").format(DateTime.parse(invoice.updatedAt ?? DateTime.now().toString()))
          , style: Theme.of(context).textTheme.headlineSmall
        )
      ),
      selected: IconButton(
        icon: const Icon(Icons.bookmark),
        onPressed: () => _onToggleBookmark(context),
      ),
      onTap: () => _redirectToInvoiceProducts(context),
      onLongPress: () {},
    );
  }
}
