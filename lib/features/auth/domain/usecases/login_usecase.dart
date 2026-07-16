
import 'package:e_commerce/features/auth/domain/entities/auth_entity.dart';
import 'package:e_commerce/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthEntity> call({
    required String username,
    required String password,
  }) {
    return repository.login(
      username: username,
      password: password,
    );
  }
}
