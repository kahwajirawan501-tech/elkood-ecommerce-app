import 'package:e_commerce/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';

class AddCartUseCase {
  final CartRepository cartRepository;
  AddCartUseCase(this.cartRepository);
  Future<CartEntity> call({required CartEntity cart})async{
    return await cartRepository.addNewCart(cart: cart);
  }

}