import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_app/crudbloc/cubits/auth_state.dart';
import 'package:presentation_app/crudbloc/models/user.dart';
import 'package:presentation_app/crudbloc/repos/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.repo}) : super(UnAuthenticatedState()) {
    UnAuthenticatedState();
  }
  final AuthRepo repo;

  Future<AuthUser> LoginUser(String email, String password) async {
    var user = AuthUser(userId: '', email: email, password: password);
    try {
      emit(UnAuthenticatedState());
      user = await repo.loginWithEmailPassword(email.trim(), password);
      emit(AuthenticatedState());
      return user;
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<AuthUser> registerUser(String email, String password) async {
    var user = AuthUser(userId: '', email: email, password: password);
    try {
      emit(UnAuthenticatedState());
      user = await repo.registerWithEmailPassword(email, password);
      emit(AuthenticatedState());
      return user;
    } catch (e) {
      print(e);
      emit(AuthErrorState());
    }
    return user;
  }

  Future<void> signOutOfApp() async{
    try{
      await repo.signOut();
      emit(UnAuthenticatedState());
    }catch (e){
      print(e);
      emit(AuthErrorState());
    }
  }

}
