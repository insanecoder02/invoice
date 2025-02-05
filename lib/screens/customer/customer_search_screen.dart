import 'package:flutter/material.dart';
import 'package:invoice/functions/core_function.dart' show t;
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/widgets/customer/customerSearchScreen/customer_search_item_widget.dart';
import 'package:invoice/widgets/global/form/search_box_widget.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/global/scroll/scroll_top_widget.dart';

class CustomerSearchScreen extends StatefulWidget {

  const CustomerSearchScreen({super.key});

  @override
  State<CustomerSearchScreen> createState() => _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends State<CustomerSearchScreen> {

  List<CustomerModel> customers = [];

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    customers = getCustomerState(context, listen: false).customers;
  }

  void _searchCustomerHandler(String value) {
    CustomerState customerState = getCustomerState(context, listen: false);
    if(customerState.scrollController.hasClients) {
      customerState.scrollController.animateTo(0, duration: const Duration(microseconds: 500), curve: Curves.bounceInOut);
    }
    value = value.toEnglishDigit().toLowerCase();
    customers = customerState.customers.where((customer) => customer.name.toLowerCase().contains(value) || customer.nationalCode.toLowerCase().contains(value) || customer.phone.toLowerCase().contains(value) || customer.address.toLowerCase().contains(value)).toList();
    setState(() {});
  }

  void _onCloseHandler() {
    CustomerState customerState = getCustomerState(context, listen: false);
    setState(() => customers = customerState.customers);
    if(customerState.scrollController.hasClients) {
      customerState.scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 65.0,
        title: SearchBoxWidget(focusNode: focusNode, onChange: _searchCustomerHandler, onClose: _onCloseHandler),
        actions: const [
          SizedBox(width: 20.0)
        ],
      ),
      body: customers.isNotEmpty
        ? ListView.builder(
            controller: getCustomerState(context).scrollController,
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: customers.length,
            itemBuilder: (context, index) => CustomerSearchItemWidget(customers[index], index)
          )
        : CenterMessageWidget(message: t(context).noResultsFound),
      floatingActionButton: ScrollTopWidget(getCustomerState(context, listen: false).scrollController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
