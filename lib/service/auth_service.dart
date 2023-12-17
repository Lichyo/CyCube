import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async =>
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async =>
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> logout() async{
    await _auth.signOut();
  }

  Future<User?> get currentUser async{
    return _auth.currentUser;
  }
}