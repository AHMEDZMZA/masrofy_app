import 'category_report_model.dart';

class ReportDataItems {
  final double totalIncome;
  final double totalExpenses;
  final double netIncome;
  final double savingRate;
  final double? incomeChange;
  final double? expenseChange;
  final List<CategoryReportModel> expensesByCategory;

  ReportDataItems({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netIncome,
    required this.savingRate,
    this.incomeChange,
    this.expenseChange,
    required this.expensesByCategory,
  });
}
