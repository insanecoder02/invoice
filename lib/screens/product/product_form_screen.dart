import 'package:flutter/material.dart';
import 'package:invoice/database/sqlite/tables/products_table_sqlite_database.dart';
import 'package:invoice/functions/core_function.dart' show t, showSnackBarWidget, navigatorByPop;
import 'package:invoice/models/product_model.dart';
import 'package:invoice/states/global_form_state.dart';
import 'package:invoice/states/product_state.dart';
import 'package:invoice/widgets/product/productFormScreen/product_text_form_fields_widget.dart';

class ProductFormScreen extends StatefulWidget {

  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _codeExistsError;
  
  String? _nameExistsError;

  bool _isLoading = false;

  showSnackBarErrorForm() => showSnackBarWidget(context, content: Text(t(context).formError), duration: const Duration(seconds: 3));

  void _onProcessForm() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);
      getGlobalFormState(context, listen: false).isCreateForm
        ? _productCreate(context) 
        : _updateProduct(context);
    } else {
      showSnackBarErrorForm();
    }
  }

  dynamic _productCreate(context) async {
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;

    List<ProductModel> resultCode = getProductState(context, listen: false).products.where((product) => product.code == formData['code']).toList();
    List<ProductModel> resultNameCategory = getProductState(context, listen: false).products.where((product) => product.name == formData['name'] && product.categoryId != formData['categoryId']).toList();
    _codeExistsError = resultCode.isNotEmpty ? t(context).alreadyExisted(t(context).code) : null;
    _nameExistsError = resultNameCategory.isNotEmpty ? t(context).alreadyExisted("${t(context).name} - ${t(context).category}") : null;

    if(resultCode.isNotEmpty || resultNameCategory.isNotEmpty) {
      setState(() => _isLoading = false);
      return showSnackBarErrorForm();
    }

    formData['seenAt'] = DateTime.now().toString();

    ProductsTableSqliteDatabase().create(ProductModel.fromJson(formData))
      .then((int id) {
        setState(() => _isLoading = false);
        getProductState(context, listen: false).addProduct(ProductModel.fromJson({...formData, 'id': id}));
        navigatorByPop(context);
      }).catchError((error) => _errorHandler(error));
  }

  dynamic _updateProduct(context) async {
    Map<String, dynamic> formData = getGlobalFormState(context, listen: false).formData;

    List<ProductModel> resultCode = getProductState(context, listen: false).products.where((product) => product.code == formData['code'] && product.id != formData['id']).toList();
    List<ProductModel> resultNameCategory = getProductState(context, listen: false).products.where((product) => product.name == formData['name'] && product.categoryId != formData['categoryId'] && product.id != formData['id']).toList();
    _codeExistsError = resultCode.isNotEmpty ? t(context).alreadyExisted(t(context).code) : null;
    _nameExistsError = resultNameCategory.isNotEmpty ? t(context).alreadyExisted("${t(context).name} - ${t(context).category}") : null;

    if(resultCode.isNotEmpty || resultNameCategory.isNotEmpty) {
      setState(() => _isLoading = false);
      return showSnackBarErrorForm();
    }

    formData['seenAt'] = DateTime.now().toString();

    ProductsTableSqliteDatabase().update(ProductModel.fromJson(formData))
      .then((int id) {
        setState(() => _isLoading = false);
        getProductState(context, listen: false).updateProduct(ProductModel.fromJson(formData));
        navigatorByPop(context, result: ProductModel.fromJson(formData));
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
          title: Text(globalFormState.isCreateForm ? t(context).productCreate : t(context).productEdit, style: Theme.of(context).textTheme.headlineLarge),
          actions: [
            IconButton(
              icon: const Icon(Icons.check, size: 30.0),
              onPressed: !_isLoading ? _onProcessForm : null,
            ),
            const SizedBox(width: 10.0)
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            children: [
              ProductTextFormFieldsWidget(_codeExistsError, _nameExistsError),
            ],
          )
        )
      )
    );
  }
}
