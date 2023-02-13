import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_app/crudbloc/cubits/auth_state.dart';
import 'package:presentation_app/crudbloc/models/user.dart';
import 'package:presentation_app/crudbloc/repos/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.repo}) : super(InitialState()) {
    InitialState();
  }
  final AuthRepo repo;

  void LoginUser(String email, String password) async {
    try {
      emit(UnAuthenticatedState(state.mainAuthState));
      var user = await repo.loginWithEmailPassword(email.trim(), password);
      emit(AuthenticatedState(state.mainAuthState));
    } catch (e) {
      emit(AuthErrorState(state.mainAuthState, e.toString()));
    }
  }

  void registerUser(String email, String password) async {
    try {
      emit(UnAuthenticatedState(state.mainAuthState));
      var user = await repo.registerWithEmailPassword(email, password);
      emit(AuthenticatedState(state.mainAuthState));
    } catch (e) {
      emit(AuthErrorState(state.mainAuthState, e.toString()));
    }
  }

  Future<void> signOutOfApp() async{
    try{
      await repo.signOut();
      emit(UnAuthenticatedState(state.mainAuthState));
    }catch (e){
      emit(AuthErrorState(state.mainAuthState, e.toString()));
    }
  }

}
