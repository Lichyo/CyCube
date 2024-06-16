// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cube/cube/cube_state.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> registerWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<String> createRoom({required CubeState cubeState}) async {
//     await _firestore.doc('rooms/${_auth.currentUser!.uid}').set({
//       'userName': _auth.currentUser!.email,
//       'cubeStates': cubeState.outputCubeState(),
//     });
//     return _auth.currentUser!.uid;
//   }
//
//   Future<String> updateRoom({required CubeState cubeState}) async {
//     await _firestore.doc('rooms/${_auth.currentUser!.uid}').update({
//       'cubeStates': cubeState.outputCubeState(),
//     });
//     return _auth.currentUser!.uid;
//   }
//
//   Future<void> joinRoom({required String roomID}) async {
//     await _firestore.doc('rooms/$roomID').update({
//       'teacher': _auth.currentUser!.email,
//     });
//   }
// }
