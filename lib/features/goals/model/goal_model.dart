class GoalModel {
  final String id;
  final String title;
  final double current;
  final double target;

  GoalModel({
    required this.id,
    required this.title,
    required this.current,
    required this.target,
  });

  double get progress => target == 0 ? 0 : (current / target);

  int get percentage => (progress * 100).round();

  bool get isActive => current < target;

  factory GoalModel.fromMap(Map<String, dynamic> json, String id) {
    return GoalModel(
      id: id,
      title: json['title'] as String? ?? '',
      current: (json['current'] as num?)?.toDouble() ?? 0,
      target: (json['target'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'current': current, 'target': target};
  }
}
