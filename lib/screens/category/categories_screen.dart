import 'package:flutter/material.dart';
import 'package:invoice/constans/enums.dart';
import 'package:invoice/functions/core_function.dart' show t, navigatorByPushNamed;
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/widgets/category/categoriesScreen/category_list_widget.dart';

class CategoriesScreen extends StatelessWidget {
  
  const CategoriesScreen({super.key});

  void _redirectToCategoryCreateForm(BuildContext context) {
    GlobalFormState globalFormState =  getGlobalFormState(context, listen: false);
    globalFormState.setFormMode(FormMode.create);
    globalFormState.setFormData({...globalFormState.categoryInitialValues});
    navigatorByPushNamed(context, '/category/form');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context).categories, style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 30.0),
            onPressed: () => _redirectToCategoryCreateForm(context),
          ),
          const SizedBox(width: 10.0)
        ],
      ),
      body: const CategoryListWidget(),
    );
  }
}
