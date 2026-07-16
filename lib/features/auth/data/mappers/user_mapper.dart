
import 'package:e_commerce/features/auth/data/models/user_model.dart';
import 'package:e_commerce/features/auth/domain/entities/user_entity.dart';

extension UserMapper on UserModel {
  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      password: password,

    );
  }
}