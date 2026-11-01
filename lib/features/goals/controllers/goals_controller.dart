import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masrofy/features/goals/model/goal_model.dart';
import '../repository/goal_repository.dart';

class GoalsController extends AsyncNotifier<List<GoalModel>> {
  late final GoalRepository goalsRepo;

  @override
  FutureOr<List<GoalModel>> build() {
    goalsRepo = ref.read(goalRepoProvider);
    return _getGoals();
  }

  Future<List<GoalModel>> _getGoals() {
    return goalsRepo.getGoals();
  }

  Future<void> refreshGoals() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _getGoals();
    });
  }

  Future<void> addGoal(GoalModel goal) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await goalsRepo.addGoal(goal);
      return _getGoals();
    });
  }

  Future<void> deleteGoal(String goalId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await goalsRepo.deleteGoal(goalId);
      return _getGoals();
    });
  }

  Future<void> updateGoal(GoalModel goal) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await goalsRepo.updateGoal(goal);
      return _getGoals();
    });
  }
}

final goalsControllerProvider =
    AsyncNotifierProvider<GoalsController, List<GoalModel>>(
      GoalsController.new,
    );
