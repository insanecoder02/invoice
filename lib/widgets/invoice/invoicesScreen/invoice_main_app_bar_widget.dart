import 'package:flutter/material.dart';
import 'package:invoice/config.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, switchColor, toPersianNumber, showModalBottomSheetWidget, navigatorByPop, navigatorByPushNamed;
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/global_search_state.dart';
import 'package:invoice/states/invoice_state.dart';

class InvoiceMainAppBarWidget extends StatelessWidget implements PreferredSizeWidget{

  const InvoiceMainAppBarWidget({super.key});

  void _newCustomerHandler(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.create);
    globalFormState.setFormData({...globalFormState.customerInitialValues});
    navigatorByPop(context);
    navigatorByPushNamed(context, '/customer/form');
  }

  void _registeredCustomerHandler(BuildContext context) {
    navigatorByPop(context);
    navigatorByPushNamed(context, '/customer/search');
  }

  void _addInvoiceHandler(BuildContext context) {
    showModalBottomSheetWidget(
      context,
      initialChildSize: .2,
      content: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.add),
            title: Text(t(context).newCustomer),
            onTap: () => _newCustomerHandler(context),
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle_outlined),
            title: Text(t(context).registeredCustomer),
            onTap: () => _registeredCustomerHandler(context),
          )
        ],
      )
    );
  }

  void _switchToSearchAppBar(BuildContext context) {
    GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);
    globalSearchState.setAppBarType(AppBarType.searchAppBar);
    globalSearchState.setSearchValue('');
  }

  List<int> _getLengthInvoiceAndPreinvoice(BuildContext context) {
    int lengthPreinvoice = 0;
    int lengthInvoice = 0;
    getInvoiceState(context).invoices.forEach((invoice) {
      invoice.type == 0 ? lengthPreinvoice++ : lengthPreinvoice;
      invoice.type == 1 ? lengthInvoice++ : lengthInvoice;
    });

    return [lengthPreinvoice, lengthInvoice];
  }

  @override
  Widget build(BuildContext context) {
    InvoiceState invoiceState = getInvoiceState(context);
    final [lengthPreinvoice, lengthInvoice] = _getLengthInvoiceAndPreinvoice(context);

    return AppBar(
      title: invoiceState.selectedInvoices.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t(context).invoices, style: Theme.of(context).textTheme.headlineLarge),

              if(lengthPreinvoice > 0 || lengthInvoice > 0) 
              FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  children: [
                    if(lengthPreinvoice > 0)                        Text("${toPersianNumber(context, lengthPreinvoice.toString(), onlyConvert: true)} ${t(context).preinvoice}", style: Theme.of(context).textTheme.headlineSmall),
                    if(lengthPreinvoice > 0 && lengthInvoice > 0)   Text(' - ', style: Theme.of(context).textTheme.headlineSmall),
                    if(lengthInvoice > 0)                           Text("${toPersianNumber(context, lengthInvoice.toString(), onlyConvert: true)} ${t(context).invoice}", style: Theme.of(context).textTheme.headlineSmall),
                  ]
                ),
              )
            ]
          )
        : null,
      actions: [
        if(invoiceState.selectedInvoices.isEmpty)
        IconButton(
          icon: const Icon(Icons.search, size: 25.0),
          onPressed: () => _switchToSearchAppBar(context)
        ),

        if(invoiceState.selectedInvoices.isEmpty)
        IconButton(
          icon: const Icon(Icons.add, size: 30.0),
          onPressed: () => _addInvoiceHandler(context),
        ),

        if(invoiceState.selectedInvoices.isNotEmpty)
        Row(
          children: [
            Text("${toPersianNumber(context, invoiceState.selectedInvoices.length.toString(), onlyConvert: true)} ${t(context).selected}", style: const TextStyle(fontSize: 16.0)),
            IconButton(
              icon: invoiceState.selectedInvoices.length == invoiceState.invoices.length ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
              onPressed: () => invoiceState.selectedInvoices.length != invoiceState.invoices.length ? getInvoiceState(context, listen: false).addSelectedInvoices() : getInvoiceState(context, listen: false).removeSelectedInvoices()
            )
          ],
        ),
        
        invoiceState.selectedInvoices.isNotEmpty
          ? const SizedBox(width: 20.0)
          : const SizedBox(width: 10.0)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
