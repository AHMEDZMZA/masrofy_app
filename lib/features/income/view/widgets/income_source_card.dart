import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/extensions/num_extension.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';
import '../../model/category.dart';
import '../../model/income_model.dart';

class IncomeSourceCard extends StatelessWidget {
  const IncomeSourceCard({super.key, required this.entry, required this.onTap});

  final IncomeModel entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final category = IncomeCategories.values.firstWhere(
      (e) => e.key == entry.category,
      orElse: () => IncomeCategories.other,
    );
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.rL),
      child: Container(
        padding: 16.allPadding,
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.rL),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            // Category icon
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.rM),
              ),
              child: Icon(
                category.icon,
                color: category.color,
                size: AppSizes.iconM,
              ),
            ),
            AppSizes.m.horizontalSpace,

            // Title & description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (entry.description.isNotEmpty) ...[
                    AppSizes.xs.verticalSpace,
                    Text(
                      entry.description,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            AppSizes.m.horizontalSpace,

            // Amount
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${entry.amount} ${'currency_egp_short'.tr()}',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColors.income,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSizes.xs.verticalSpace,
                Text(
                  category.label,
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
      ),
    );
  }
}
