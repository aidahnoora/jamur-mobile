import 'package:jamur/models/product_model.dart';

class HistoryItemModel {
  int? id;
  int? userId;
  int? productId;
  int? transactionId;
  int? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProductModel? product;

  HistoryItemModel({
    this.id,
    this.userId,
    this.productId,
    this.transactionId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory HistoryItemModel.fromJson(Map<String, dynamic> json) {
    return HistoryItemModel(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      transactionId: json['transaction_id'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: ProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'transaction_id': transactionId,
      'quantity': quantity,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'product': product?.toJson(),
    };
  }
}