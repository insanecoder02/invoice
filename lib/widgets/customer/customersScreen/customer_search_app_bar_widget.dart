import 'package:flutter/material.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/widgets/global/form/search_box_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomerSearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget{

  const CustomerSearchAppBarWidget({super.key});

  @override
  State<CustomerSearchAppBarWidget> createState() => _CustomerSearchAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _CustomerSearchAppBarWidgetState extends State<CustomerSearchAppBarWidget> {

  final FocusNode focusNode = FocusNode();

  List<Map> customersMap = [];

  @override
  void initState() {
    super.initState();
    _convertModelListTOMapListForInvoices();
  }

  void _convertModelListTOMapListForInvoices() {
    customersMap = getCustomerState(context, listen: false).customers.map((CustomerModel customer) {
      return {
        "name": customer.name.toLowerCase(),
        "nationalCode": customer.nationalCode.toLowerCase(),
        "phone": customer.phone.toLowerCase(),
        "address": customer.address.toLowerCase(),
        "customer": customer
      };
    }).toList();
  }

  void _searchCustomersHandler(String value) {
    value = value.toEnglishDigit().toLowerCase();

    List<CustomerModel> customers = [];
    customersMap.toList().forEach((Map customer) {
      if( customer["name"].toLowerCase().contains(value)         ||
          customer["nationalCode"].toLowerCase().contains(value) ||
          customer["phone"].toLowerCase().contains(value)        ||
          customer["address"].toLowerCase().contains(value)
        ) {
          customers.add(customer["customer"]);
        }
    });

    CustomerState customerState = getCustomerState(context, listen: false);
    customerState.addCustomers(customers);
    ScrollController scrollController = customerState.scrollController;
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
  }

  void _onCloseHandler() {
    CustomerState customerState = getCustomerState(context, listen: false);
    customerState.addCustomers(customerState.tempCustomers);
    ScrollController scrollController = customerState.scrollController;
    if(scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    getCustomerState(context);
    
    return AppBar(
      titleSpacing: 0,
      title: SearchBoxWidget(focusNode: focusNode, onChange: _searchCustomersHandler, onClose: _onCloseHandler),
      actions: const [SizedBox(width: 20.0)],
    );
  }
}
