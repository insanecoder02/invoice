import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/config.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/models/invoice_model.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/global_search_state.dart';
import 'package:invoice/states/invoice_state.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber, switchColor;
import 'package:invoice/widgets/global/form/search_box_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class InvoiceSearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget{

  const InvoiceSearchAppBarWidget({super.key});

  @override
  State<InvoiceSearchAppBarWidget> createState() => _InvoiceSearchAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _InvoiceSearchAppBarWidgetState extends State<InvoiceSearchAppBarWidget> {

  final FocusNode focusNode = FocusNode();

  List<Map> invoicesMap = [];

  @override
  void initState() {
    super.initState();
    _convertModelListTOMapListForInvoices();
  }

  void _convertModelListTOMapListForInvoices() {
    List<CustomerModel> customers = getCustomerState(context, listen: false).customers;
    invoicesMap = getInvoiceState(context, listen: false).invoices.map((InvoiceModel invoice) {

      String invoiceNumber = (invoice.id!.toInt() + Config.baseInvoiceNumber).toString();
      String invoiceType = invoice.getType ? 'فاکتور' : 'پیش فاکتور';
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

  void _searchInvoicesHandler(String value) {
    value = value.toEnglishDigit().toLowerCase();
    GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);
    globalSearchState.setSearchValue(value);

    List<InvoiceModel> invoices = [];
    invoicesMap.toList().forEach((Map invoice) {
      if( invoice['invoiceNumber'].contains(value) ||
          invoice['invoiceType'] == value
          // invoice['name'].contains(value)       ||
          // invoice['phone'].contains(value)      ||
      ) {
        invoices.add(invoice['invoice']);
      }
    });

    InvoiceState invoiceState = getInvoiceState(context, listen: false);
    invoiceState.addInvoices(invoices);
    ScrollController invoiceScrollController = invoiceState.invoiceScrollController;
    if(invoiceScrollController.hasClients) {
      invoiceScrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
  }

  dynamic _onSelectHandler() {
    getInvoiceState(context, listen: false).addSelectedInvoices(customInvoices: getInvoiceState(context, listen: false).invoices);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  dynamic _onDeleteHandler() {
    getInvoiceState(context, listen: false).removeSelectedInvoices();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void _onCloseHandler() {
    InvoiceState invoiceState = getInvoiceState(context, listen: false);
    invoiceState.addInvoices(invoiceState.tempInvoices);
    ScrollController invoiceScrollController = invoiceState.invoiceScrollController;
    if(invoiceScrollController.hasClients) {
      invoiceScrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);
    globalSearchState.setSearchValue('');
  }

  @override
  Widget build(BuildContext context) {
    InvoiceState invoiceState = getInvoiceState(context);

    int lengthPreinvoice = 0;
    int lengthInvoice = 0;
    getInvoiceState(context).invoices.forEach((invoice) {
      invoice.type == 0 ? lengthPreinvoice++ : lengthPreinvoice;
      invoice.type == 1 ? lengthInvoice++ : lengthInvoice;
    });

    return AppBar(
      titleSpacing: 0,
      title: Opacity(opacity: invoiceState.selectedInvoices.isEmpty ? 1 : 0, child: SearchBoxWidget(focusNode: focusNode, onChange: _searchInvoicesHandler, onClose: _onCloseHandler)),
      actions: [
        if(invoiceState.selectedInvoices.isNotEmpty)
        Row(
          children: [
            Text("${toPersianNumber(context, invoiceState.selectedInvoices.length.toString(), onlyConvert: true)} ${t(context).selected}", style: const TextStyle(fontSize: 16.0)),
            IconButton(
              icon: invoiceState.selectedInvoices.length == invoiceState.invoices.length ? Icon(Config.iconChecked, color: switchColor(context, light: Config.brandColor)) : Icon(Config.iconUnChecked),
              onPressed: () => invoiceState.selectedInvoices.length != invoiceState.invoices.length ? _onSelectHandler() : _onDeleteHandler()
            )
          ],
        ),
        const SizedBox(width: 20.0)
      ],
    );
  }
}
