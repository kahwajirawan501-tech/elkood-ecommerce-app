import 'package:e_commerce/features/cart/domain/entities/cart_item_entity.dart';

import '../../domain/entities/cart_entity.dart';
import '../models/cart_model.dart';


extension CartMapperToEntity on CartModel {
  CartEntity toEntity() {
    return CartEntity(
      userId: userId,
      date: date,
      items: products.map((item) => CartItemEntity(
        productId: item.productId,
        quantity: item.quantity,
      )).toList(),
    );
  }
}
extension CartModelListMapper on List<CartModel> {
  List<CartEntity> toEntityList() {
    return map((model) => model.toEntity()).toList();
  }
}