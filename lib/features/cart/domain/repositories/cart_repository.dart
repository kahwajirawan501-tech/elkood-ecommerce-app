import 'package:e_commerce/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<CartEntity> addNewCart({required CartEntity cart});
  Future<List<CartEntity>> getAllCarts();
}