

import 'package:e_commerce/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:e_commerce/features/auth/data/mappers/user_info_mapper.dart';
import 'package:e_commerce/features/profile/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthLocalDataSource localDataSource;
  ProfileCubit(this.localDataSource) : super(ProfileInitial());

  Future<void> getUserData() async {
    emit(ProfileLoading());
    try {
      final user = await localDataSource.getUser();
      if (user != null) {
        emit(ProfileLoaded(user.toEntity()));
      } else {
        emit(ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}