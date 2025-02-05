import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/categories_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget, navigatorByPop;
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/category_state.dart';
import 'package:invoice/models/category_model.dart';
import 'package:invoice/widgets/category/categoryFormScreen/category_name_field_widget.dart';

class CategoryFormScreen extends StatefulWidget {

  const CategoryFormScreen({super.key});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _existsError;

  bool _isLoading = false;

  void _showSnackBarErrorForm() => showSnackBarWidget(context, content: Text(t(context).formError), duration: const Duration(seconds: 3));

  void _onProcessForm() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);
      getGlobalFormState(context, listen: false).isCreateForm
        ? _categoryCreate() 
        : _updateCategory();
    } else {
      _showSnackBarErrorForm();
    }
  }

  dynamic _categoryCreate() async {

    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;
    CategoryState categoryState = getCategoryState(context, listen: false);

    List<CategoryModel> result = categoryState.categories.where((CategoryModel category) => category.name == formData['name']).toList();
    
    if(result.isNotEmpty) {
      setState(() => _existsError = t(context).alreadyExisted(t(context).name));
      setState(() => _isLoading = false);
      return _showSnackBarErrorForm();
    }

    CategoriesTableSqliteDatabase().create(CategoryModel.fromJson(formData))
      .then((int id) {
        setState(() => _isLoading = false);
        categoryState.addCategory(CategoryModel.fromJson({...formData, 'id': id}));
        navigatorByPop(context);
      }).catchError((error) => _errorHandler(error));
  }

  dynamic _updateCategory() {
    
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;
    CategoryState categoryState = getCategoryState(context, listen: false);

    List<CategoryModel> result = categoryState.categories.where((CategoryModel category) => category.name == formData['name'] && category.id != formData['id']).toList();
    
    if(result.isNotEmpty) {
      setState(() => _existsError = t(context).alreadyExisted(t(context).name));
      setState(() => _isLoading = false);
      return _showSnackBarErrorForm();
    }

    CategoriesTableSqliteDatabase().update(CategoryModel.fromJson(formData))
      .then((int id) {
        setState(() => _isLoading = false);
        categoryState.updateCategory(CategoryModel.fromJson(formData));
        navigatorByPop(context);
      }).catchError((error) => _errorHandler(error));
  }

  dynamic _errorHandler(dynamic error) {
    setState(() => _isLoading = false);
    showSnackBarWidget(context, content: Text(t(context).dbError));
  }

  @override
  Widget build(BuildContext context) {
    GlobalFormState globalFormState = getGlobalFormState(context);

    return WillPopScope(
      onWillPop: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(globalFormState.isCreateForm ? t(context).categoryCreate : t(context).categoryEdit, style: Theme.of(context).textTheme.headlineLarge),
          actions: [
            IconButton(
              icon: const Icon(Icons.check, size: 30.0),
              onPressed: !_isLoading ? _onProcessForm : null,
            ),
            const SizedBox(width: 10.0)
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryNameFieldWidget(_existsError),
                const SizedBox(height: 20.0),
              ],
            )
          )
        )
      ),
    );
  }
}
