import 'package:jamur/models/category_model.dart';
import 'package:jamur/models/gallery_model.dart';

class ProductModel {
  int? id;
  String? name;
  double? price;
  String? description;
  String? tags;
  CategoryModel? category;
  double? stock;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<GalleryModel>? galleries;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.tags,
    this.category,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.galleries,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        price: double.parse(json['price'].toString()),
        description: json['description'],
        tags: json['tags'],
        category: CategoryModel.fromJson(json['category']),
        stock: double.parse(json['stock'].toString()),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        galleries: List<GalleryModel>.from(
          json['galleries'].map((gallery) => GalleryModel.fromJson(gallery)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'description': description,
        'tags': tags,
        'category': category?.toJson(),
        'stock': stock,
        'created_at': createdAt.toString(),
        'updated_at': createdAt.toString(),
        'galleries': galleries?.map((gallery) => gallery.toJson()).toList(),
      };
}

class UninitializedProductModel extends ProductModel {}
