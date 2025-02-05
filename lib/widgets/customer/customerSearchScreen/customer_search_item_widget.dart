import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/customers_table_sqlite_database.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/functions/core_function.dart' show switchColor, toPersianNumber, navigatorByPushReplacementNamed;
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/customer_state.dart';

class CustomerSearchItemWidget extends StatelessWidget {

  final CustomerModel customer;
  
  final int index;

  const CustomerSearchItemWidget(this.customer, this.index, {super.key});

  void _redirectToCustomerInvoices(BuildContext context) {
    CustomerModel customerModel = CustomerModel.fromJson({...customer.toMap(), 'seenAt': DateTime.now().toString()});
    CustomersTableSqliteDatabase().update(customerModel).then((int id) {
      getCustomerState(context, listen: false).updateCustomer(customerModel);
      getCustomerInvoicesState(context, listen: false).setCustomer(customerModel);
      navigatorByPushReplacementNamed(context, "/customer/invoices");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      tileColor: index.isOdd ? switchColor(context, light: Colors.grey.shade50, dark: Colors.blueGrey.shade800.withOpacity(.3)) : switchColor(context, light: Colors.grey.shade100, dark: Colors.blueGrey.shade800.withOpacity(.4)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(toPersianNumber(context, customer.nationalCode, onlyConvert: true), style: Theme.of(context).textTheme.headlineSmall),
          Text(customer.name, style: Theme.of(context).textTheme.headlineMedium),
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
      onTap: () => _redirectToCustomerInvoices(context),
    );
  }
}
