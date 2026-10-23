import 'package:flutter/material.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/themes/app_colors.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> _allGoals = [
    {
      'title': 'شراء سيارة',
      'current': '250,000',
      'target': '250,000',
      'percentage': 100,
      'progress': 1,
      'icon': Icons.directions_car_rounded,
      'color': AppColors.blue,
      'isActive': false,
    },
    {
      'title': 'سفر تركيا',
      'current': '12,500',
      'target': '25,000',
      'percentage': 50,
      'progress': 0.5,
      'icon': Icons.airplanemode_active_rounded,
      'color': AppColors.success,
      'isActive': true,
    },
    {
      'title': 'صندوق الطوارئ',
      'current': '8,000',
      'target': '10,000',
      'percentage': 80,
      'progress': 0.8,
      'icon': Icons.shield_rounded,
      'color': AppColors.success,
      'isActive': true,
    },
    {
      'title': 'شراء منزل',
      'current': '0',
      'target': '500,000',
      'percentage': 0,
      'progress': 0.0,
      'icon': Icons.home_rounded,
      'color': AppColors.expense,
      'isActive': true,
    },

    {
      'title': 'هاتف جديد',
      'current': '15,000',
      'target': '15,000',
      'percentage': 100,
      'progress': 1.0,
      'icon': Icons.phone_android_rounded,
      'color': AppColors.success,
      'isActive': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final iconColor = context.colorScheme.onSurface;

    final filteredGoals = _allGoals.where((goal) {
      if (_selectedTabIndex == 1) {
        return !goal['isActive'];
      } else {
        return goal['isActive'];
      }
    }).toList();

    return Scaffold();
  }
}
