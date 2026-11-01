import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masrofy/features/goals/model/goal_model.dart';

import '../../../core/service/firebase_service.dart';

class GoalRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  GoalRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  // get user
  CollectionReference<Map<String, dynamic>> get _goalsCollection {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('users').doc(uid).collection('goals');
  }

  /// add goal
  Future<void> addGoal(GoalModel goal) async {
    await _goalsCollection.add(goal.toMap());
  }

  /// update goal
  Future<void> updateGoal(GoalModel goal) async {
    await _goalsCollection.doc(goal.id).update(goal.toMap());
  }

  /// delete goal
  Future<void> deleteGoal(String goalId) async {
    await _goalsCollection.doc(goalId).delete();
  }

  /// list goals
  Future<List<GoalModel>> getGoals() async {
    final snapshot = await _goalsCollection.get();
    return snapshot.docs
        .map((doc) => GoalModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}

final goalRepoProvider = Provider(
  (ref) => GoalRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  ),
);
