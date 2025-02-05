import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/global_search_state.dart';
import 'package:invoice/widgets/customer/customersScreen/customer_list_widget.dart';
import 'package:invoice/widgets/customer/customersScreen/customer_main_app_bar_widget.dart';
import 'package:invoice/widgets/customer/customersScreen/customer_search_app_bar_widget.dart';
import 'package:invoice/widgets/global/scroll/scroll_top_widget.dart';

class CustomersScreen extends StatelessWidget {
  
  const CustomersScreen({super.key});

  Future<bool> _willPopScopeHandler(BuildContext context) async {
    GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);

    if(globalSearchState.appBarType == AppBarType.mainAppBar) {
      return Future.value(true);
    } else {
      CustomerState customerState = getCustomerState(context, listen: false);
      customerState.addCustomers(customerState.tempCustomers);
      globalSearchState.setAppBarType(AppBarType.mainAppBar);
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalSearchState globalSearchState = getGlobalSearchState(context);

    return WillPopScope(
      onWillPop: () => _willPopScopeHandler(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: {
          'mainAppBar': const CustomerMainAppBarWidget(),
          'searchAppBar': const CustomerSearchAppBarWidget()
        }[globalSearchState.appBarType.name],
        body: const CustomerListWidget(),
        floatingActionButton: ScrollTopWidget(getCustomerState(context, listen: false).scrollController),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      )
    );
  }
}
