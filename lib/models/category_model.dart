import 'package:invoice/models/interface_model.dart';

class CategoryModel implements InterfaceModel {
  final int? id;
  final String name;

  const CategoryModel({
    this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
