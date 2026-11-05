import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/service/firebase_service.dart';
import '../models/expense_entry_model.dart';

class ExpenseRepo {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  ExpenseRepo({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  CollectionReference<Map<String, dynamic>> get _expenseCollection {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('users').doc(uid).collection('expenses');
  }

  Future<List<ExpenseEntryModel>> getExpenseEntries() async {
    final snapshot = await _expenseCollection.orderBy('date', descending: true).get();
    return snapshot.docs
        .map((doc) => ExpenseEntryModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> addExpenseEntry(ExpenseEntryModel expense) async {
    await _expenseCollection.add(expense.toMap());
  }

  Future<void> updateExpenseEntry(ExpenseEntryModel expense) async {
    await _expenseCollection.doc(expense.id).update(expense.toMap());
  }

  Future<void> deleteExpenseEntry(String expenseId) async {
    await _expenseCollection.doc(expenseId).delete();
  }
}

final expenseRepoProvider = Provider(
  (ref) => ExpenseRepo(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  ),
);
