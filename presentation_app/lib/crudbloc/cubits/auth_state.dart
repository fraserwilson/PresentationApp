import 'package:equatable/equatable.dart';
import 'package:presentation_app/crudbloc/models/user.dart';

class MainAuthState extends Equatable{

  final AuthUser? user;

  MainAuthState({this.user});

  MainAuthState copyWith({
    AuthUser? user,
  }) {
    return MainAuthState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];

}

abstract class AuthState extends Equatable {
  final MainAuthState mainAuthState;

  AuthState(this.mainAuthState);

  @override
  List<Object?> get props => [mainAuthState];
}

class InitialState extends AuthState{
  InitialState(): super(MainAuthState());
}

class UnAuthenticatedState extends AuthState {
  UnAuthenticatedState(super.authState);
}

class AuthenticatedState extends AuthState {
  AuthenticatedState(super.authState);
}

class AuthErrorState extends AuthState {
  final String? error;

  AuthErrorState(super.authState, this.error);
}