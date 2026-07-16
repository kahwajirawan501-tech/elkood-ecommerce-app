import 'dart:convert';
import 'package:e_commerce/features/auth/data/models/user_info_model.dart';
import 'package:e_commerce/features/auth/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
   Future<void> saveUser(UserModel user);
  Future<void> saveUserInformation(UserInformationModel user);

  Future<int?> getIdUser();
  Future<UserInformationModel?> getUser();

}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
  @override

  Future<int?> getIdUser() async {
   final user = await getUser();
    return user?.id;
  }
  @override
  Future<UserInformationModel?> getUser() async {
    final data = await storage.read(key: 'user_information');

    if (data == null) return null;

    return UserInformationModel.fromJson(jsonDecode(data));
  }
  @override
  Future<void> clearToken() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'user_information');
    await storage.delete(key: 'user');
  }
  @override
  Future<void> saveUser(UserModel user) async {
    await storage.write(
      key: 'user',
      value: jsonEncode(user.toJson()),
    );

  }

  @override
  Future<void> saveUserInformation(UserInformationModel user)async {
    await storage.write(
      key: 'user_information',
      value: jsonEncode(user.toJson()),
    );  }
}