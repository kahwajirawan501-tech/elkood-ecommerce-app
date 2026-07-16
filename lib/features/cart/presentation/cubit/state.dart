
import 'package:e_commerce/features/cart/domain/entities/cart_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}


class AddLocalCartLoaded extends CartState {
  final List<CartEntity> cart;

  AddLocalCartLoaded(this.cart);
}

class AddLocalCartError extends CartState {
  final String message;

  AddLocalCartError(this.message);
}


class AddCartLoaded extends CartState {
  final CartEntity cart;

  AddCartLoaded(this.cart);
}

class AddCartError extends CartState {
  final String message;

  AddCartError(this.message);
}

class GetCartsLoaded extends CartState {
  final List<CartEntity> cart;

  GetCartsLoaded(this.cart);
}

class GetCartsError extends CartState {
  final String message;

  GetCartsError(this.message);
}