import 'package:equatable/equatable.dart';
import 'package:e_commerce/features/auth/domain/entities/user_entity.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final User user;

  const SignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError(this.message);

  @override
  List<Object?> get props => [message];
}