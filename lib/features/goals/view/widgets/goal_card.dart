import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_sizes.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final String current;
  final String target;
  final int percentage;
  final double progressValue;
  final IconData icon;
  final Color color;

  const GoalCard({
    super.key,
    required this.title,
    required this.current,
    required this.target,
    required this.percentage,
    required this.progressValue,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      padding: 16.allPadding,
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.rL),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.rM),
                ),
                child: Icon(icon, color: color, size: AppSizes.iconM),
              ),
              AppSizes.m.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.textTheme.titleMedium),
                  4.verticalSpace,
                  Text('$current ${'currency_egp_short'.tr()}', style: context.textTheme.bodyMedium),
                  2.verticalSpace,
                  Text(
                    'goals_of_target'.tr(namedArgs: {'target': target}),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Text(
                '$percentage%',
                style: context.textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              8.horizontalSpace,
              SizedBox(
                width: 80.w,
                child: ClipRRect(
                  borderRadius: 10.r.radius,
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 6.h,
                    backgroundColor: isDark
                        ? AppColors.borderDark
                        : AppColors.grey100,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
