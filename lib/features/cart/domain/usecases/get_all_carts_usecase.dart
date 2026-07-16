import 'package:e_commerce/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';

class GetAllCartsUseCase {
  final CartRepository cartRepository;
  GetAllCartsUseCase(this.cartRepository);
  Future<List<CartEntity>> call()async{
   return await cartRepository.getAllCarts();
  }

}