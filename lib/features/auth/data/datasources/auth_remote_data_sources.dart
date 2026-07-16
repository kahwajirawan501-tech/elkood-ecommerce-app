import 'package:dio/dio.dart';
import 'package:e_commerce/core/network/dio_exception_extension.dart';
import 'package:e_commerce/features/auth/data/models/auth_model.dart';
import 'package:e_commerce/features/auth/data/models/user_info_model.dart';
import 'package:e_commerce/features/auth/data/models/user_model.dart';


abstract class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String username,
    required String password,
  });
  Future<UserModel> signUp({
    required int id,
    required String username,
    required String email,
    required String password,
  });

  Future<List<UserInformationModel>>getUsers();
}
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);
  @override
  Future<AuthModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: {
          "username": username,
          "password": password,
        },
      );

      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<UserModel> signUp({
    required int id,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/users",
        data: {
          "id": id,
          "username": username,
          "email": email,
          "password": password,
        },
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<List<UserInformationModel>> getUsers() async{
    try {
      final response = await dio.get(
        "/users"
      );
      return (response.data as List)
          .map((userJson) => UserInformationModel.fromJson(userJson))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }



}