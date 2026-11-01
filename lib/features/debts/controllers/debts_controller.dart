import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masrofy/features/debts/model/debts_model.dart';
import '../repository/debts_repository.dart';

class DebtsController extends AsyncNotifier<List<DebtsModel>> {
  late final DebtsRepository _debtsRepo;

  @override
  FutureOr<List<DebtsModel>> build() {
    _debtsRepo = ref.read(debtsRepoProvider);
    return _getDebts();
  }

  Future<List<DebtsModel>> _getDebts() {
    return _debtsRepo.getDebt();
  }

  Future<void> refreshDebts() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _getDebts();
    });
  }

  Future<void> addDebt(DebtsModel debts) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _debtsRepo.addDebt(debts);
      return _getDebts();
    });
  }

  Future<void> deleteDebt(String debtsId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _debtsRepo.deleteDebt(debtsId);
      return _getDebts();
    });
  }

  Future<void> updateDebt(DebtsModel debts) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _debtsRepo.updateDebt(debts);
      return _getDebts();
    });
  }
}

final debtsControllerProvider =
    AsyncNotifierProvider<DebtsController, List<DebtsModel>>(
      DebtsController.new,
    );
