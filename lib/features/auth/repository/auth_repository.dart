import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:masrofy/features/auth/models/user_model.dart';
import '../../../core/service/firebase_service.dart';

class AuthRepository {
  /// call firestore , auth , google sing in

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn googleSignIn,
  }) : _auth = auth,
       _firestore = firestore,
       _googleSignIn = googleSignIn;

  // build sing in fun

  Future<UserCredential?> signInWithGoogle() async {
    /// 1- open and choose email
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      /// 2- choose email = auth
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      /// 3- create credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      /// 4- pass credential to firebase auth
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        await _saveUserToFirestore(userCredential.user!);
      }
      return userCredential;
    } catch (e, st) {
      log("error $e", stackTrace: st);
      rethrow;
    }
  }

  // get user state auth false
  User? get currentUser => _auth.currentUser;

  // get user
  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  // save user to firestore
  Future<void> _saveUserToFirestore(User user) async {
    final userModel = UserModel.fromFirestore(user);
    await _usersCollection.doc(user.uid).set(userModel.toMap());
  }

  /// Sign out
  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }
}

final authRepoProvider = Provider(
  (ref) => AuthRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  ),
);
