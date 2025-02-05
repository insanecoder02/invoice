import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPushNamed, showModalBottomSheetWidget, navigatorByPop;
import 'package:invoice/states/global_form_state.dart';

class HomeFloatingActionButtonWidget extends StatelessWidget {

  const HomeFloatingActionButtonWidget({super.key});

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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: DateTime.now().microsecondsSinceEpoch,
      child: const Icon(Icons.add),
      onPressed: () {
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
    );
  }
}
