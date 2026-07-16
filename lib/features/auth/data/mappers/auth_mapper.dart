import 'package:e_commerce/features/auth/domain/entities/auth_entity.dart';

import '../models/auth_model.dart';

extension AuthMapper on AuthModel {
  AuthEntity toEntity() {
    return AuthEntity(
      token: token,
    );
  }
}