import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../debts/controllers/debts_controller.dart';
import '../../expenses/controller/expense_controller.dart';
import '../../goals/controllers/goals_controller.dart';
import '../../goals/model/progress_goals.dart';
import '../../income/controllers/income_controller.dart';

final thisMonthIncomeProvider = Provider<double>((ref) {
  final incomeProvider = ref.watch(incomeControllerProvider);
  final currentMonth = DateTime.now().month;
  final currentYear = DateTime.now().year;
  return incomeProvider.maybeWhen(
    orElse: () => 0.0,
    data: (incomes) => incomes
        .where((e) => e.month == currentMonth && e.year == currentYear)
        .fold(0, (sum, e) => sum + e.amount),
  );
});

final thisMonthExpenseProvider = Provider<double>((ref) {
  final expenseProvider = ref.watch(expenseControllerProvider);
  final currentMonth = DateTime.now().month;
  final currentYear = DateTime.now().year;

  return expenseProvider.maybeWhen(
    orElse: () => 0.0,
    data: (expenses) => expenses
        .where((e) => e.month == currentMonth && e.year == currentYear)
        .fold(0, (sum, e) => sum + e.amount),
  );
});

final thisMonthBalanceProvider = Provider<double>((ref) {
  final income = ref.watch(thisMonthIncomeProvider);
  final expense = ref.watch(thisMonthExpenseProvider);
  return income - expense;
});

final todayExpenseProvider = Provider<double>((ref) {
  final expenseProvider = ref.watch(expenseControllerProvider);
  final today = DateTime.now().day;
  final currentMonth = DateTime.now().month;
  final currentYear = DateTime.now().year;

  return expenseProvider.maybeWhen(
    orElse: () => 0.0,
    data: (expenses) => expenses
        .where(
          (e) =>
              e.month == currentMonth &&
              e.year == currentYear &&
              e.date.day == today,
        )
        .fold(0, (sum, e) => sum + e.amount),
  );
});

final unpaidDebtsProvider = Provider<double>((ref) {
  final debtsProvider = ref.watch(debtsControllerProvider);
  return debtsProvider.maybeWhen(
    orElse: () => 0.0,
    data: (debts) => debts
        .where((d) => !d.isPaid)
        .fold(0, (sum, d) => sum + d.remainingAmount),
  );
});

final goalsProgressProvider = Provider<GoalsProgress>((ref) {
  final goalsProvider = ref.watch(goalsControllerProvider);
  return goalsProvider.maybeWhen(
    orElse: () => GoalsProgress(completed: 0, total: 0),
    data: (gaols) {
      final total = gaols.length;
      final completed = gaols.where((g) => !g.isActive).length;
      return GoalsProgress(completed: completed, total: total);
    },
  );
});
