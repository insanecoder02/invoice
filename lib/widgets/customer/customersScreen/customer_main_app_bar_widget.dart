import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber, navigatorByPushNamed;
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/global_search_state.dart';

class CustomerMainAppBarWidget extends StatelessWidget implements PreferredSizeWidget{

  const CustomerMainAppBarWidget({super.key});

  void _redirectToCustomerCreateForm(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.create);
    globalFormState.setFormData({...globalFormState.customerInitialValues});
    navigatorByPushNamed(context, '/customer/form');
  }

  void _switchToSearchAppBar(BuildContext context) {
    GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);
    globalSearchState.setAppBarType(AppBarType.searchAppBar);
    globalSearchState.setSearchValue('');
  }

  @override
  Widget build(BuildContext context) {
    List<CustomerModel> customers = getCustomerState(context).customers;

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t(context).customers, style: Theme.of(context).textTheme.headlineLarge),
          if(customers.isNotEmpty) 
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              children: [
                Text("${toPersianNumber(context, customers.length.toString(), onlyConvert: true)} ${t(context).customer}", style: Theme.of(context).textTheme.headlineSmall),
              ]
            ),
          )
        ]
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, size: 25.0),
          onPressed: () => _switchToSearchAppBar(context)
        ),
        IconButton(
          icon: const Icon(Icons.add, size: 30.0),
          onPressed: () => _redirectToCustomerCreateForm(context),
        ),
        const SizedBox(width: 10.0)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
