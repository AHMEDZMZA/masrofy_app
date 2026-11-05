import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense_entry_model.dart';
import '../repository/expense_repo.dart';

class ExpenseController extends AsyncNotifier<List<ExpenseEntryModel>> {
  late final ExpenseRepo expenseRepo;

  @override
  FutureOr<List<ExpenseEntryModel>> build() {
    expenseRepo = ref.read(expenseRepoProvider);
    return _getExpenseEntries();
  }

  FutureOr<List<ExpenseEntryModel>> _getExpenseEntries() async {
    return await expenseRepo.getExpenseEntries();
  }

  Future<void> refreshExpenseEntries() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _getExpenseEntries();
    });
  }

  Future<void> addExpenseEntry(ExpenseEntryModel expense) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await expenseRepo.addExpenseEntry(expense);
      return _getExpenseEntries();
    });
  }

  Future<void> updateExpenseEntry(ExpenseEntryModel expense) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await expenseRepo.updateExpenseEntry(expense);
      return _getExpenseEntries();
    });
  }

  Future<void> deleteExpenseEntry(String expenseId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await expenseRepo.deleteExpenseEntry(expenseId);
      return _getExpenseEntries();
    });
  }
}

final expenseControllerProvider =
    AsyncNotifierProvider<ExpenseController, List<ExpenseEntryModel>>(
      ExpenseController.new,
    );
