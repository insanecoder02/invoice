import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/database/sqlite/tables/customers_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, switchColor, navigatorByPushNamed, showDialogWidget, navigatorByPop, toPersianNumber;
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/invoice_state.dart';

class CustomerItemWidget extends StatelessWidget {
  
  final int index;
  
  final CustomerModel customer;

  const CustomerItemWidget(this.index, this.customer, {super.key});

  void _redirectToCustomerInvoices(BuildContext context) {
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context,listen: false);
    customerInvoicesState.setCustomer(customer);
    navigatorByPushNamed(context, '/customer/invoices');
  }

  void _redirectCustomerToEditForm(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.update);
    globalFormState.setFormData(customer.toMap());
    navigatorByPushNamed(context, '/customer/form');
  }

  void _removeCustomerHandler(BuildContext context) {
    showDialogWidget(context,
      content: Text("${t(context).descriptionForDeleteCustomer}, ${t(context).areYouSure(t(context).delete)}"),
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
        CustomerState customerState = getCustomerState(context, listen: false);
        CustomersTableSqliteDatabase().remove(customer).then((int count) {
          customerState.removeCustomer(customer);
          InvoiceState invoiceState = getInvoiceState(context, listen: false);
          invoiceState.removeCustomerInvoices(customer.id ?? 0);
        });
      }
    });
  }

  List<int> _getLengthInvoiceAndPreinvoice(BuildContext context) {
    int lengthPreinvoice = 0;
    int lengthInvoice = 0;
    getInvoiceState(context).invoices.forEach((invoice) {
      invoice.customerId == customer.id && invoice.type == 0 ? lengthPreinvoice++ : lengthPreinvoice;
      invoice.customerId == customer.id && invoice.type == 1 ? lengthInvoice++ : lengthInvoice;
    });

    return [lengthPreinvoice, lengthInvoice];
  }

  @override
  Widget build(BuildContext context) {
    final [lengthPreinvoice, lengthInvoice] = _getLengthInvoiceAndPreinvoice(context);

    return ListTile(
      contentPadding: EdgeInsets.only(left: isRTL(context) ? 10.0 : 20.0, right: isRTL(context) ? 20.0 : 10.0, top: 10.0, bottom: 10.0),
      tileColor: index.isOdd ? switchColor(context, light: Colors.grey.shade50, dark: Colors.blueGrey.shade800.withOpacity(.3)) : switchColor(context, light: Colors.grey.shade100, dark: Colors.blueGrey.shade800.withOpacity(.4)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(toPersianNumber(context, customer.nationalCode, onlyConvert: true), style: Theme.of(context).textTheme.headlineSmall),
          Text(customer.name, style: Theme.of(context).textTheme.headlineMedium),
          Row(
            children: [
              if(lengthPreinvoice > 0)                        Text("${toPersianNumber(context, lengthPreinvoice.toString())} ${t(context).preinvoice}", style: Theme.of(context).textTheme.headlineSmall),
              if(lengthPreinvoice > 0 && lengthInvoice > 0)   Text(' - ', style: Theme.of(context).textTheme.headlineSmall),
              if(lengthPreinvoice == 0 && lengthInvoice == 0) Text(t(context).withoutPreinvoiceOrInvoice, style: Theme.of(context).textTheme.headlineSmall),
              if(lengthInvoice > 0)                           Text("${toPersianNumber(context, lengthInvoice.toString())} ${t(context).invoice}", style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: 20.0),
        ]
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.phone, size: 16.0,),
              const SizedBox(width: 10.0),
              Text(toPersianNumber(context, customer.phone, onlyConvert: true), style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18.0,),
              const SizedBox(width: 10.0),
              Expanded(child: Text(customer.address, style: Theme.of(context).textTheme.headlineSmall))
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(child: Text(t(context).edit), onTap: () => _redirectCustomerToEditForm(context)),
          PopupMenuItem(child: Text(t(context).delete), onTap: () =>_removeCustomerHandler(context)),
        ],
      ),
      onTap: () => _redirectToCustomerInvoices(context),
    );
  }
}
