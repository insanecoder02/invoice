import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/config.dart';
import 'package:invoice/functions/core_function.dart' show t, isRTL, switchColor, navigatorByPushNamed, toPersianNumber;
import 'package:invoice/widgets/global/cards/invoice_card_widget.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/states/invoice_state.dart';

class HomeLatestInvoiceItemWidget extends StatefulWidget {
  
  final InvoiceModel invoice;

  const HomeLatestInvoiceItemWidget(this.invoice, {super.key});

  @override
  State<HomeLatestInvoiceItemWidget> createState() => _HomeLatestInvoiceItemWidgetState();
}

class _HomeLatestInvoiceItemWidgetState extends State<HomeLatestInvoiceItemWidget> {

  void _onTapHandler() {
    InvoiceState invoiceState = getInvoiceState(context, listen: false);

    if(invoiceState.selectedInvoices.isNotEmpty) {
      if(!invoiceState.selectedInvoices.contains(widget.invoice)) {
        invoiceState.addSelectedInvoice(widget.invoice);
      } else {
        invoiceState.removeSelectedInvoice(widget.invoice);
      }
    } else {
      InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
      invoiceProductsState.setInvoiceModel(widget.invoice);
      invoiceProductsState.setTotalPrice(0);
      List<CustomerModel> customers = getCustomerState(context, listen: false).customers;
      CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context, listen: false);
      CustomerModel customer = customers.where((customer) => customer.id == widget.invoice.customerId).first;
      customerInvoicesState.setCustomer(customer);
      customerInvoicesState.addCustomerInvoices(invoiceState.invoices.where((invoice) => invoice.customerId == customer.id).toList());
      navigatorByPushNamed(context, '/invoice/products');
    }
  }

  void _onLongPressHandler() {
    InvoiceState invoiceState = getInvoiceState(context, listen: false);
    if(!invoiceState.selectedInvoices.contains(widget.invoice)) {
      invoiceState.addSelectedInvoice(widget.invoice);
    } else {
      invoiceState.removeSelectedInvoice(widget.invoice);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    InvoiceState invoiceState = getInvoiceState(context);
    List<CustomerModel> customers = getCustomerState(context).customers;

    return InvoiceCardWidget(
      onTap: _onTapHandler,
      onLongPress: _onLongPressHandler,
      title: Text(customers.where((CustomerModel customer) => customer.id == widget.invoice.customerId).first.name, style: Theme.of(context).textTheme.headlineMedium),
      subtitle: Row(
        children: [
          Text(widget.invoice.getType ? t(context).invoice : t(context).preinvoice, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(width: 10),
          Text(toPersianNumber(context, (widget.invoice.id!.toInt() + Config.baseInvoiceNumber).toString(), onlyConvert: true), style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
        ],
      ),
      trailing: Text(
        isRTL(context)
          ? DateTime.parse(widget.invoice.updatedAt ?? DateTime.now().toString()).toPersianDateStr()
          : DateFormat("dd MMM y").format(DateTime.parse(widget.invoice.updatedAt ?? DateTime.now().toString()))
        , style: Theme.of(context).textTheme.headlineSmall
      ),
      selected: invoiceState.selectedInvoices.isNotEmpty ? invoiceState.selectedInvoices.contains(widget.invoice) ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked) : null
    );
  }
}
