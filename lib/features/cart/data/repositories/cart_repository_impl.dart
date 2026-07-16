import 'package:e_commerce/features/cart/data/datasources/cart_remote_data_sources.dart';
import 'package:e_commerce/features/cart/data/mappers/cart_mapper_to_entity.dart';
import 'package:e_commerce/features/cart/data/mappers/cart_mapper_to_model.dart';
import 'package:e_commerce/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSources cartRemoteDataSources;

  CartRepositoryImpl(this.cartRemoteDataSources);

  @override
  Future<CartEntity> addNewCart({required CartEntity cart}) async {
    final cartModel = cart.toModel();

    final result = await cartRemoteDataSources.addNewCart(cart: cartModel);

    return result.toEntity();
  }

  @override
  Future<List<CartEntity>> getAllCarts() async {
    final result = await cartRemoteDataSources.getAllCarts();

    return result.toEntityList();
  }
}