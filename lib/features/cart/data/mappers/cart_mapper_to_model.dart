import 'package:e_commerce/features/cart/data/models/cart_item_model.dart';
import 'package:e_commerce/features/product/data/mappers/product_mapper_to_model.dart';

import '../../domain/entities/cart_entity.dart';
import '../models/cart_model.dart';


extension CartMapperToModel on CartEntity {
  CartModel toModel() {
    return CartModel(
      userId: userId!,
      date: date!,
      products: items.map((item) => CartItemModel(
        productId: item.productId,
        quantity: item.quantity,
      )).toList(),
    );
  }
}

