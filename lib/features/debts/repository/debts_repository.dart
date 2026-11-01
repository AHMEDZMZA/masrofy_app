import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/service/firebase_service.dart';
import '../model/debts_model.dart';

class DebtsRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  DebtsRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  // get user
  CollectionReference<Map<String, dynamic>> get _debtsCollection {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('users').doc(uid).collection('debts');
  }

  /// addDebt
  Future<void> addDebt(DebtsModel debts) async {
    await _debtsCollection.add(debts.toMap());
  }

  /// updateDebt
  Future<void> updateDebt(DebtsModel debts) async {
    await _debtsCollection.doc(debts.id).update(debts.toMap());
  }

  /// deleteDebt
  Future<void> deleteDebt(String debtsId) async {
    await _debtsCollection.doc(debtsId).delete();
  }

  /// listDebts
  Future<List<DebtsModel>> getDebt() async {
    final snapshot = await _debtsCollection.get();
    return snapshot.docs
        .map((doc) => DebtsModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}

final debtsRepoProvider = Provider(
  (ref) => DebtsRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  ),
);
