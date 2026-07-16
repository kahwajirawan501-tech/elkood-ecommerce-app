
import 'package:e_commerce/features/auth/domain/entities/auth_entity.dart';
import 'package:e_commerce/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login({
    required String username,
    required String password,
  });
  Future <User> signup({
    required int id,
    required String username,
    required String email,
    required String password,
  });

}
