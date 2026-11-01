class DebtsModel {
  final String id;
  final String title;

  /// الشخص المديون منه
  final String creditor;

  /// الدين كامل

  final double totalAmount;

  /// الدين المدفوع

  final double paidAmount;

  DebtsModel({
    required this.id,
    required this.title,
    required this.creditor,
    required this.totalAmount,
    required this.paidAmount,
  });

  double get remainingAmount => totalAmount - paidAmount;

  double get progress => totalAmount == 0 ? 0 : (paidAmount / totalAmount);

  int get percentage => (progress * 100).round();

  bool get isPaid => remainingAmount <= 0;

  factory DebtsModel.fromMap(Map<String, dynamic> json, String id) {
    return DebtsModel(
      id: id,
      title: json['title'] as String? ?? '',
      creditor: json['creditor'] as String? ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
      paidAmount: (json['paidAmount'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'creditor': creditor,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
    };
  }
}
