import 'package:invoice/models/interface_model.dart';

class InvoiceModel implements InterfaceModel {
  final int? id;
  final int customerId;
  final int type;
  final int cashDiscount;
  final int volumeDiscount;
  final String? description;
  late int bookmark;
  final String? createdAt;
  final String? updatedAt;

  InvoiceModel({
    this.id,
    required this.customerId,
    required this.type,
    this.cashDiscount = 0,
    this.volumeDiscount = 0,
    this.description,
    required this.bookmark,
    this.createdAt,
    this.updatedAt
  });
  
  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      customerId: int.parse(json['customerId'].toString()),
      type: int.parse(json['type'].toString()),
      cashDiscount: int.parse(json['cashDiscount'].toString()),
      volumeDiscount: int.parse(json['volumeDiscount'].toString()),
      description: json['description'],
      bookmark: int.parse(json['bookmark'].toString()),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'type': type,
      'cashDiscount': cashDiscount,
      'volumeDiscount': volumeDiscount,
      'description': description,
      'bookmark': bookmark,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  bool get getType => type == 0 ? false : true;

  bool get getBookmark => bookmark == 0 ? false : true;
}
