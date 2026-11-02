import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/income_model.dart';
import '../repository/income_repository.dart';

class IncomeController extends AsyncNotifier<List<IncomeModel>> {
  late final IncomeRepository incomeRepo;

  @override
  FutureOr<List<IncomeModel>> build() {
    incomeRepo = ref.read(incomeRepoProvider);
    return _getIncomeEntries();
  }

  FutureOr<List<IncomeModel>> _getIncomeEntries() {
    return incomeRepo.getIncomeEntries();
  }

  Future<void> refreshIncomeEntries() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _getIncomeEntries();
    });
  }

  Future<void> addIncomeEntry(IncomeModel income) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await incomeRepo.addIncomeEntry(income);
      return _getIncomeEntries();
    });
  }

  Future<void> updateIncomeEntry(IncomeModel income) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await incomeRepo.updateIncomeEntry(income);
      return _getIncomeEntries();
    });
  }

  Future<void> deleteIncomeEntry(String incomeId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await incomeRepo.deleteIncomeEntry(incomeId);
      return _getIncomeEntries();
    });
  }
}

final incomeControllerProvider =
    AsyncNotifierProvider<IncomeController, List<IncomeModel>>(
      IncomeController.new,
    );
