import 'package:e_commerce/features/cart/domain/entities/cart_item_entity.dart';

class CartEntity {
  final int? userId;
  final String? date;
  final List<CartItemEntity> items;

  CartEntity({this.userId, this.date, required this.items});
}