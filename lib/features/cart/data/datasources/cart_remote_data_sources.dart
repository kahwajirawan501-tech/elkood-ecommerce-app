import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/dio_exception_extension.dart';
import 'package:e_commerce/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSources {
  Future<CartModel> addNewCart({required CartModel cart});
  Future<List<CartModel>> getAllCarts();
}

class CartRemoteDataSourcesImpl implements CartRemoteDataSources {
  final Dio dio;
  CartRemoteDataSourcesImpl(this.dio);

  @override
  Future<CartModel> addNewCart({required CartModel cart}) async {
    try {
      final response = await dio.post("/carts", data: cart.toJson());

      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<List<CartModel>> getAllCarts() async {
    try {
      final response = await dio.get("/carts");

      final  data = response.data as List;
      return data.map((item) => CartModel.fromJson(item)).toList();

    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }
}