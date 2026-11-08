import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masrofy/core/themes/app_colors.dart';

class IncomeCategory {
  final String key;
  final IconData icon;
  final Color color;

  const IncomeCategory({
    required this.key,
    String? label,
    required this.icon,
    required this.color,
  });

  String get label => 'income_category_$key'.tr();
}

class IncomeCategories {
  static const salary = IncomeCategory(
    key: 'salary',
    icon: Icons.business_center_rounded,
    color: AppColors.primary,
  );

  static const freelance = IncomeCategory(
    key: 'freelance',
    icon: Icons.laptop_mac_rounded,
    color: AppColors.purple,
  );

  static const investment = IncomeCategory(
    key: 'investment',
    icon: Icons.trending_up_rounded,
    color: AppColors.cyan,
  );

  static const bonus = IncomeCategory(
    key: 'bonus',
    icon: Icons.card_giftcard_rounded,
    color: AppColors.accent,
  );

  static const other = IncomeCategory(
    key: 'other',
    icon: Icons.more_horiz_rounded,
    color: AppColors.success,
  );

  static const values = [
    salary,
    freelance,
    investment,
    bonus,
    other,
  ];
}
