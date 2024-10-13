import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final String uid = userCredential.user!.uid;
      await _firestore.collection('users').doc(uid).set({
        "email": email,
        "name": name,
        "role": role,
      });
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return Future.error('Google Sign In Failed');
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get user => _auth.authStateChanges();
}
