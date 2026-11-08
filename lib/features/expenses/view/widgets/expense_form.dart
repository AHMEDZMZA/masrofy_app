import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';
import 'package:masrofy/core/widgets/custom_text_field.dart';
import 'package:masrofy/features/expenses/models/expnese_category.dart';

class ExpenseFormSheet extends StatelessWidget {
  const ExpenseFormSheet({
    super.key,
    required this.isDark,
    required this.isEditing,
    required this.titleController,
    required this.descriptionController,
    required this.amountController,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.onSave,
    required this.onDelete,
  });

  final bool isDark;
  final bool isEditing;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController amountController;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback onSave;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : AppColors.grey300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            AppSizes.m.verticalSpace,

            // Title
            Text(
              isEditing ? 'expenses_form_edit_title'.tr() : 'expenses_form_add_title'.tr(),
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            AppSizes.l.verticalSpace,

            CustomTextField(
              controller: titleController,
              label: 'expenses_form_field_name'.tr(),
              hint: 'expenses_form_field_name_hint'.tr(),
              prefixIcon: const Icon(Icons.title_rounded),
            ),
            AppSizes.m.verticalSpace,

            CustomTextField(
              controller: amountController,
              label: 'expenses_form_field_amount'.tr(),
              hint: '0.00',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              prefixIcon: const Icon(Icons.payments_rounded),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Text(
                  'currency_egp_short'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            AppSizes.m.verticalSpace,

            CustomTextField(
              controller: descriptionController,
              label: 'expenses_form_field_description'.tr(),
              prefixIcon: const Icon(Icons.notes_rounded),
            ),
            AppSizes.l.verticalSpace,

            // Category selector
            Text(
              'expenses_form_category_label'.tr(),
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            AppSizes.s.verticalSpace,
            SizedBox(
              height: 80.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemCount: ExpenseCategory.categories.length,
                separatorBuilder: (_, _) => 10.horizontalSpace,
                itemBuilder: (context, index) {
                  final category = ExpenseCategory.categories[index];
                  final key = category.id;
                  final isSelected = selectedCategory == key;
                  final color = category.color;

                  return GestureDetector(
                    onTap: () => onCategoryChanged(key),
                    child: Column(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? color
                                : color.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: color.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            category.icon,
                            color: isSelected ? Colors.white : color,
                            size: 22.sp,
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          category.name,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: isSelected
                                ? (isDark ? Colors.white : Colors.black)
                                : AppColors.grey500,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            AppSizes.l.verticalSpace,

            // Actions
            Column(
              children: [
                if (isEditing && onDelete != null)
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: onDelete,
                      child: Text(
                        'expenses_form_delete_btn'.tr(),
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onSave,
                    child: Text(isEditing ? 'expenses_form_update_btn'.tr() : 'expenses_form_save_btn'.tr()),
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
