import 'package:e_commerce/features/auth/domain/usecases/signup_usecase.dart';
import 'package:e_commerce/features/auth/presentation/cubit/signup_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignupUseCase signupUseCase;

  SignUpCubit(this.signupUseCase) : super(SignUpInitial());

  Future<void> signUp({
    required int id,
    required String username,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      final user = await signupUseCase(
        id: id,
        username: username,
        email: email,
        password: password,
      );

      emit(SignUpSuccess(user));
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}