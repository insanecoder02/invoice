import 'package:invoice/models/interface_model.dart';

class ProductModel implements InterfaceModel {
  final int? id;
  final int categoryId;
  final String code;
  final String name;
  final int volume;
  final int unit;
  final int quantityInBox;
  final int price;
  final String? seenAt;

  const ProductModel({
    this.id,
    required this.categoryId,
    required this.code,
    required this.name,
    required this.volume,
    required this.unit,
    required this.quantityInBox,
    required this.price,
    this.seenAt
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: int.parse(json['categoryId'].toString()),
      code: json['code'],
      name: json['name'],
      volume: int.parse(json['volume'].toString()),
      unit: int.parse(json['unit'].toString()),
      quantityInBox: int.parse(json['quantityInBox'].toString()),
      price: int.parse(json['price'].toString().replaceAll(',', '')),
      seenAt: json['seenAt']
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'code': code,
      'name': name,
      'volume': volume,
      'unit': unit,
      'quantityInBox': quantityInBox,
      'price': price,
      'seenAt': seenAt
    };
  }
}
