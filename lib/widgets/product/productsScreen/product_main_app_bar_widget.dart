import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, toPersianNumber, navigatorByPushNamed;
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/global_search_state.dart';
import 'package:invoice/states/product_state.dart';

class ProductMainAppBarWidget extends StatelessWidget implements PreferredSizeWidget{

  const ProductMainAppBarWidget({super.key});

  void _redirectToProductCreateForm(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.create);
    globalFormState.setFormData({...globalFormState.productInitialValues});
    navigatorByPushNamed(context, '/product/form');
  }

  void _switchToSearchAppBar(BuildContext context) {
    GlobalSearchState globalSearchState = getGlobalSearchState(context, listen: false);
    globalSearchState.setAppBarType(AppBarType.searchAppBar);
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = getProductState(context).products;

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t(context).products, style: Theme.of(context).textTheme.headlineLarge),
          if(products.isNotEmpty) 
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              children: [
                Text("${toPersianNumber(context, products.length.toString(), onlyConvert: true)} ${t(context).product}", style: Theme.of(context).textTheme.headlineSmall),
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
          onPressed: () => _redirectToProductCreateForm(context),
        ),
        const SizedBox(width: 10.0)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
