import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthState {
  AuthenticatedState();

  @override
  List<Object> get props => [];
}

class AuthErrorState extends AuthState {
  @override
  List<Object> get props => [];
}