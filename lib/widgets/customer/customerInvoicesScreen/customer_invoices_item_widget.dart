import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice/config.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber, isRTL, switchColor, navigatorByPush;
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/screens/invoiceProducts/invoice_products_screen.dart';
import 'package:invoice/widgets/global/cards/invoice_card_widget.dart';
import 'package:invoice/states/customer_invoices_state.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/invoice_products_state.dart';
import 'package:invoice/states/invoice_state.dart';

class CustomerInvoicesItemWidget extends StatefulWidget {
  
  final InvoiceModel invoice;
  
  final int index;

  const CustomerInvoicesItemWidget(this.invoice, this.index, {super.key});

  @override
  State<CustomerInvoicesItemWidget> createState() => _CustomerInvoicesItemWidgetState();
}

class _CustomerInvoicesItemWidgetState extends State<CustomerInvoicesItemWidget> {

  void _onTapHandler() {
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context, listen: false);

    if(customerInvoicesState.selectedCustomerInvoices.isNotEmpty) {
      if(!customerInvoicesState.selectedCustomerInvoices.contains(widget.invoice)) {
        customerInvoicesState.addSelectedCustomerInvoice(widget.invoice);
      } else {
        getInvoiceState(context, listen: false).removeSelectedInvoice(widget.invoice);
        customerInvoicesState.removeSelectedCustomerInvoice(widget.invoice);
      }
    } else {
      InvoiceProductsState invoiceProductsState = getInvoiceProductsState(context, listen: false);
      invoiceProductsState.setInvoiceModel(widget.invoice);
      invoiceProductsState.setTotalPrice(0);
      List<CustomerModel> customers = getCustomerState(context, listen: false).customers;
      getCustomerInvoicesState(context, listen: false).setCustomer(customers.where((customer) => customer.id == widget.invoice.customerId).first);
      navigatorByPush(context, const InvoiceProductsScreen(redirectToCustomerInvoicesEnable: false));
    }
  }

  void _onLongPressHandler() {
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context, listen: false);

    if(!customerInvoicesState.selectedCustomerInvoices.contains(widget.invoice)) {
      customerInvoicesState.addSelectedCustomerInvoice(widget.invoice);
    } else {
      getInvoiceState(context, listen: false).removeSelectedInvoice(widget.invoice);
      customerInvoicesState.removeSelectedCustomerInvoice(widget.invoice);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    CustomerInvoicesState customerInvoicesState = getCustomerInvoicesState(context);

    return InvoiceCardWidget(
      onTap: _onTapHandler,
      onLongPress: _onLongPressHandler,
      title: Column(
        children: [
          if(widget.invoice.cashDiscount > 0)
          Row(
            children: [
              Text("${toPersianNumber(context, widget.invoice.cashDiscount.toString())}%", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(width: 5.0),
              Text(t(context).cashDiscount, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
      
          if(widget.invoice.volumeDiscount > 0)
          Row(
            children: [
              Text("${toPersianNumber(context, widget.invoice.volumeDiscount.toString())}%", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(width: 5.0),
              Text(t(context).volumeDiscount, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),

          if(widget.invoice.cashDiscount == 0 && widget.invoice.volumeDiscount == 0)
          Text(t(context).withoutDiscount, style: Theme.of(context).textTheme.headlineMedium),
        ]
      ),
      subtitle: Row(
        children: [
          Text(widget.invoice.getType ? t(context).invoice : t(context).preinvoice, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(width: 10),
          Text(toPersianNumber(context, (widget.invoice.id!.toInt() + Config.baseInvoiceNumber).toString(), onlyConvert: true), style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
        ],
      ),
      trailing: Text(
        isRTL(context)
          ? DateTime.parse(widget.invoice.createdAt ?? DateTime.now().toString()).toPersianDateStr()
          : DateFormat("dd MMM y").format(DateTime.parse(widget.invoice.createdAt ?? DateTime.now().toString()))
        , style: Theme.of(context).textTheme.headlineSmall
      ),
      selected: customerInvoicesState.selectedCustomerInvoices.isNotEmpty ? customerInvoicesState.selectedCustomerInvoices.contains(widget.invoice) ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked) : null,
    );
  }
}
