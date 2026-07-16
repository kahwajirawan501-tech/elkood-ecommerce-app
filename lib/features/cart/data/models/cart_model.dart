import 'package:e_commerce/features/cart/data/models/cart_item_model.dart';

class CartModel {
  final int userId;
  final String date;
  final List<CartItemModel> products;

  CartModel({required this.userId, required this.date, required this.products});
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(userId: json["userId"], date: json["date"],
      products: (json['products'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'date': date,
    'products': products.map((e) => e.toJson()).toList(),
  };
}