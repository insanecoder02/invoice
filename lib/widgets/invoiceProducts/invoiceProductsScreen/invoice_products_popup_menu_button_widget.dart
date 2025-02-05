import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/invoices_table_sqlite_database.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, showSnackBarWidget, showModalBottomSheetWidget, navigatorByPushReplacementNamed, navigatorByPop, navigatorByPushNamed, showDialogWidget;
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:intl/intl.dart';

class InvoiceProductsPopupMenuButtonWidget extends StatelessWidget {

  final bool redirectToCustomerInvoicesEnable;

  const InvoiceProductsPopupMenuButtonWidget({super.key, required this.redirectToCustomerInvoicesEnable});

  void _redirectToCustomerInvoices(BuildContext context) {
    if(redirectToCustomerInvoicesEnable) {
      navigatorByPushReplacementNamed(context, '/customer/invoices');
    } else {
      navigatorByPop(context);
    }
  }

  void _redirectToEditInvoiceHead(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.update);
    globalFormState.setFormData(getInvoiceProductsState(context, listen: false).invoice.toMap());
    navigatorByPushNamed(context, '/invoice/form');
  }

  void _showDialogForRemove(BuildContext context) {
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
        _removeInvoicesHandler(context);
      }
    });
  }

  void _removeInvoicesHandler(BuildContext context) {
    InvoiceProductsState invoiceState = getInvoiceProductsState(context, listen: false);
    InvoicesTableSqliteDatabase().remove(invoiceState.invoice).then((int count) {
      if(count == 1) {
        getInvoiceState(context, listen: false).removeInvoice(invoiceState.invoice);
        getCustomerInvoicesState(context, listen: false).removeCustomerInvoice(invoiceState.invoice);
        navigatorByPop(context);
      }
    }).catchError((error) {/*Todo: Error Handler*/});
  }

  void _redirectToEditCustomer(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    List<CustomerModel> customers =  getCustomerState(context, listen: false).customers;
    int customerId = getInvoiceProductsState(context, listen: false).invoice.customerId;
    CustomerModel customer = customers.where((customer) => customer.id == customerId).first;
    globalFormState.setFormMode(FormMode.update);
    globalFormState.setFormData(customer.toMap());
    navigatorByPushNamed(context, '/customer/form');
  }

  void _invoiceBookmarkHandler(BuildContext context, bool bookmark) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    InvoiceModel invoice = getInvoiceProductsState(context, listen: false).invoice;
    invoice.bookmark = bookmark ? 0 : 1;
    InvoicesTableSqliteDatabase().update(invoice).then((int id) {
      getInvoiceState(context, listen: false).invoices.forEach((item) => item.id == invoice.id ? item.bookmark = bookmark ? 0 : 1 : null);
      getCustomerInvoicesState(context, listen: false).customerInvoices.forEach((item) => item.id == invoice.id ? item.bookmark = bookmark ? 0 : 1 : null);
      showSnackBarWidget(context, 
        content: Row(
          children: [
            Icon(bookmark ? Icons.bookmark_remove : Icons.bookmark_add, color: Config.foregroundDark),
            const SizedBox(width: 10.0),
            Text(bookmark ? t(context).unBookmarked(t(context).invoice) : t(context).bookmarked(t(context).invoice)),
          ]
        ),
        duration: const Duration(seconds: 2),
        actionLabel: ''
      );
    });
  }

  void _showInvoiceDetails(BuildContext context) {
    InvoiceModel invoice = getInvoiceProductsState(context, listen: false).invoice;

    showModalBottomSheetWidget(context,
      initialChildSize: .5,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setStateSetter) => Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: isRTL(context) ? 10.0 : 20.0, right: isRTL(context) ? 20.0 : 10.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(.1)))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t(context).invoiceDetails, style: Theme.of(context).textTheme.headlineMedium),
                  IconButton(
                    icon: Icon(Icons.close, size: 25.0, color: Theme.of(context).colorScheme.primary.withOpacity(.3)),
                    onPressed: () => navigatorByPop(context)
                  ),
                ],
              )
            ),
            Expanded(
              child: ListView(
                physics: const ScrollPhysics(),
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_month_outlined),
                    title: Padding(padding: const EdgeInsets.only(bottom: 5.0), child: Text(t(context).invoiceRegistration, style: Theme.of(context).textTheme.headlineSmall)),
                    subtitle: Text(
                      isRTL(context)
                        ? DateTime.parse(invoice.createdAt!).toPersianDate(showTime: true).replaceAll(" ", "  -  ")
                        : DateFormat("dd MMM y  -  HH:mm").format(DateTime.parse(invoice.createdAt!)),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0)
                    )
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit_calendar_outlined),
                    title: Padding(padding: const EdgeInsets.only(bottom: 5.0), child: Text(t(context).dateLastEdit, style: Theme.of(context).textTheme.headlineSmall)),
                    subtitle: Text(
                      isRTL(context)
                        ? DateTime.parse(invoice.updatedAt!).toPersianDate(showTime: true).replaceAll(" ", "  -  ")
                        : DateFormat("dd MMM y  -  HH:mm").format(DateTime.parse(invoice.updatedAt!)),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0)
                    ),
                  ),
                ]
              ),
            )
          ],
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    InvoiceModel invoice = getInvoiceProductsState(context).invoice;

    return  PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(invoice.getType ? t(context).invoiceEdit : t(context).preinvoiceEdit),
              Text("+ ${t(context).description}", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 10.0))
            ]
          ),
          onTap: () => _redirectToEditInvoiceHead(context),
        ),

        PopupMenuItem(
          child: Text(t(context).invoiceDelete),
          onTap: () => _showDialogForRemove(context),
        ),

        PopupMenuItem(
          child: Row(
            children: [
              if(!redirectToCustomerInvoicesEnable)
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.arrow_back, size: 18.0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t(context).invoices),
                  Text("+ ${t(context).invoiceCreate}", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 10.0)),
                ]
              ),
            ],
          ),
          onTap: () => _redirectToCustomerInvoices(context),
        ),

        PopupMenuItem(
          child: Text(t(context).customerEdit),
          onTap: () => _redirectToEditCustomer(context),
        ),

        PopupMenuItem(
          child: Text(t(context).invoiceDetails),
          onTap: () => _showInvoiceDetails(context),
        ),
        
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              invoice.getBookmark ? Text("${t(context).delete} ${t(context).bookmark}") : Text(t(context).bookmark),
              invoice.getBookmark ? Icon(Icons.bookmark_rounded, color: Theme.of(context).colorScheme.primary) : Icon(Icons.bookmark_border, color: Theme.of(context).colorScheme.primary),
            ],
          ),
          onTap: () => _invoiceBookmarkHandler(context, invoice.getBookmark),
        )
      ],
    );
  }
}
