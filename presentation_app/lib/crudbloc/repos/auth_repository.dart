import 'package:firebase_auth/firebase_auth.dart';
import 'package:presentation_app/crudbloc/models/user.dart';

class AuthRepo {

  Future<AuthUser> loginWithEmailPassword(String email, String password) async {
    AuthUser user = AuthUser(userId: '', email: email, password: password);
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    user.copyWith(userId: userCredential.user!.uid, email: userCredential.user!.email!, password: userCredential.user!.email!);

    return user;
  }

  Future<AuthUser> registerWithEmailPassword(String email, String password) async {
    AuthUser user = AuthUser(userId: '', email: email, password: password);
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user.copyWith(userId: userCredential.user!.uid, email: userCredential.user!.email!, password: userCredential.user!.email!);
    return user;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}