import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/widgets/customer/customerInvoicesScreen/customer_invoices_bottom_navigation_bar_widget.dart';
import 'package:invoice/widgets/customer/customerInvoicesScreen/customer_invoices_list_widget.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPushNamed, toPersianNumber, switchColor;
import 'package:invoice/widgets/global/scroll/scroll_top_widget.dart';

class CustomerInvoicesScreen extends StatelessWidget {
  
  const CustomerInvoicesScreen({super.key});

  void _addInvoiceHandler(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.create);
    globalFormState.setFormData({...globalFormState.invoiceInitialValues});
    navigatorByPushNamed(context, '/invoice/form');
  }

  Future<bool> _willPopScopeHandler(BuildContext context) async {
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context, listen: false);
    
    if(customerInvoicesState.selectedCustomerInvoices.isNotEmpty) {
      customerInvoicesState.removeSelectedCustomerInvoices();
      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context);
    bool isSelectedCustomerInvoices = customerInvoicesState.selectedCustomerInvoices.isNotEmpty;

    int lengthPreinvoice = 0;
    int lengthInvoice = 0;
    getInvoiceState(context).invoices.forEach((invoice) {
      invoice.customerId == customerInvoicesState.customer.id && invoice.type == 0 ? lengthPreinvoice++ : lengthPreinvoice;
      invoice.customerId == customerInvoicesState.customer.id && invoice.type == 1 ? lengthInvoice++ : lengthInvoice;
    });

    return WillPopScope(
      onWillPop: () => _willPopScopeHandler(context),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(customerInvoicesState.customer.name, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 21.0), overflow: TextOverflow.ellipsis),

              if(customerInvoicesState.selectedCustomerInvoices.isNotEmpty)
              Text("${toPersianNumber(context, customerInvoicesState.selectedCustomerInvoices.length.toString())}  ${t(context).selected}", style: Theme.of(context).textTheme.headlineSmall),

              if(customerInvoicesState.selectedCustomerInvoices.isEmpty)
              Row(
                children: [
                  if(lengthPreinvoice > 0)                        Text("${toPersianNumber(context, lengthPreinvoice.toString(), onlyConvert: true)} ${t(context).preinvoice}", style: Theme.of(context).textTheme.headlineSmall),
                  if(lengthPreinvoice > 0 && lengthInvoice > 0)   Text(' - ', style: Theme.of(context).textTheme.headlineSmall),
                  if(lengthInvoice > 0)                           Text("${toPersianNumber(context, lengthInvoice.toString(), onlyConvert: true)} ${t(context).invoice}", style: Theme.of(context).textTheme.headlineSmall),
                ],
              )
            ]
          ),
          actions: [
            if(customerInvoicesState.selectedCustomerInvoices.isEmpty)
            IconButton(
              icon: const Icon(Icons.add, size: 30.0),
              onPressed: () => _addInvoiceHandler(context),
            ),

            if(customerInvoicesState.selectedCustomerInvoices.isNotEmpty)
            IconButton(
              icon: customerInvoicesState.selectedCustomerInvoices.length == customerInvoicesState.customerInvoices.length ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
              onPressed: () => customerInvoicesState.selectedCustomerInvoices.length != customerInvoicesState.customerInvoices.length ? getCustomerInvoicesState(context, listen: false).addSelectedCustomerInvoices() : getCustomerInvoicesState(context, listen: false).removeSelectedCustomerInvoices()
            ),
            
            customerInvoicesState.selectedCustomerInvoices.isNotEmpty
              ? const SizedBox(width: 20.0)
              : const SizedBox(width: 10.0)
          ],
        ),
        body: const Column(
          children: [
            CustomerInvoicesListWidget()
          ],
        ),
        bottomNavigationBar: isSelectedCustomerInvoices ? const CustomerInvoicesBottomNavigationBarWidget() : null,
        floatingActionButton: ScrollTopWidget(getCustomerInvoicesState(context, listen: false).scrollController),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      )
    );
  }
}
