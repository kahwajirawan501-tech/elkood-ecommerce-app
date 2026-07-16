
import 'package:e_commerce/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

class SignupUseCase{
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future <User>call({
    required int id,
    required String username,
    required String email,
    required String password,
  }) {
    return repository.signup(
      id:id ,
      username:username ,
      email: email,
      password: password,
    );
  }
}
