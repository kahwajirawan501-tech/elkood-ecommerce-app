
import 'package:e_commerce/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:e_commerce/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:e_commerce/features/auth/data/mappers/auth_mapper.dart';
import 'package:e_commerce/features/auth/data/mappers/user_mapper.dart';
import 'package:e_commerce/features/auth/domain/entities/auth_entity.dart';
import 'package:e_commerce/features/auth/domain/entities/user_entity.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(this.remoteDataSource,this.localDataSource);

  @override
  Future<AuthEntity> login({
    required String username,
    required String password,
  }) async {
    final authModel = await remoteDataSource.login(
      username: username,
      password: password,
    );

    await localDataSource.clearToken();
    await localDataSource.saveToken(authModel.token);

    final allUsers = await remoteDataSource.getUsers();

    final currentUser = allUsers.firstWhere(
          (user) => user.username == username,
      orElse: () => throw Exception("User details not found"),
    );

    await localDataSource.saveUserInformation(currentUser);

    return authModel.toEntity();
  }
  @override
  Future<User> signup({
    required int id,
    required String username,
    required String email,
    required String password,
  }) async {
    final model = await remoteDataSource.signUp(
      id: id,
      username:username,
      email: email,
      password: password,
    );
    await localDataSource.saveUser(model);

    return model.toEntity();
  }


}
