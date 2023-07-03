class HistoryModel {
  int? id;
  int? userId;
  String? address;
  double? totalPrice;
  double? shippingPrice;
  String? status;
  String? payment;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  HistoryModel({
    this.id,
    this.userId,
    this.address,
    this.totalPrice,
    this.shippingPrice,
    this.status,
    this.payment,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      userId: json['user_id'],
      address: json['address'],
      totalPrice: json['total_price'].toDouble(),
      shippingPrice: json['shipping_price'].toDouble(),
      status: json['status'],
      payment: json['payment'],
      url: json['url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'address': address,
      'total_price': totalPrice,
      'shipping_price': shippingPrice,
      'status': status,
      'payment': payment,
      'url': url,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}