import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/service/firebase_service.dart';
import '../model/income_model.dart';

class IncomeRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  IncomeRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  CollectionReference<Map<String, dynamic>> get _incomeCollection {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('users').doc(uid).collection('income');
  }

  Future<List<IncomeModel>> getIncomeEntries() async {
    final snapshot = await _incomeCollection.get();
    return snapshot.docs
        .map((doc) => IncomeModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> addIncomeEntry(IncomeModel income) async {
    await _incomeCollection.add(income.toMap());
  }

  Future<void> updateIncomeEntry(IncomeModel income) async {
    await _incomeCollection.doc(income.id).update(income.toMap());
  }

  Future<void> deleteIncomeEntry(String incomeId) async {
    await _incomeCollection.doc(incomeId).delete();
  }
}

final incomeRepoProvider = Provider(
  (ref) => IncomeRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  ),
);
