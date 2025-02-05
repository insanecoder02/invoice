import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/customers_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget;
import 'package:invoice/models/customer_model.dart';
import 'package:invoice/states/customer_state.dart';
import 'package:invoice/widgets/customer/customersScreen/customer_item_widget.dart';
import 'package:invoice/widgets/global/messages/center_message_widget.dart';
import 'package:invoice/widgets/global/progresses/progress_full_screen_widget.dart';

class CustomerListWidget extends StatefulWidget {

  const CustomerListWidget({super.key});

  @override
  State<CustomerListWidget> createState() => _CustomerListWidgetState();
}

class _CustomerListWidgetState extends State<CustomerListWidget> {

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  void _onChangeIsLoding(bool value) => setState(() => _isLoading = value);

  _initialData() {
    CustomerState customerState = getCustomerState(context, listen: false);
    if(customerState.customers.isEmpty) {
      _onChangeIsLoding(true);
      CustomersTableSqliteDatabase().all().then((List<CustomerModel> customers) {
        customerState.addCustomers(customers, withTemp: true);
        _onChangeIsLoding(false);
      }).catchError((error) {
        _onChangeIsLoding(false);
        showSnackBarWidget(
          context,
          content: Text(t(context).fetchDataError),
          actionLabel: t(context).tryAgain,
          onPressed: _initialData
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomerState customerState = getCustomerState(context);

    return ! _isLoading
      ? customerState.customers.isNotEmpty
        ? ListView.builder(
            controller: customerState.scrollController,
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            itemCount: customerState.customers.length,
            itemBuilder: (context, index) => CustomerItemWidget(index, customerState.customers[index]),
          )
        : CenterMessageWidget(message: t(context).noCustomers, subMessage: t(context).tapAddCustomers)
      : const ProgressFullScreenWidget.center();
  }
}
