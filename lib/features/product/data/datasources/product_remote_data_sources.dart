import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/dio_exception_extension.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get("/products");

      final List<dynamic> data = response.data;

      return data.map((e) => ProductModel.fromJson(e)).toList();

    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }
}