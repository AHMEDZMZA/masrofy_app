import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';
import '../../model/category.dart';

class IncomeFormSheet extends StatelessWidget {
  const IncomeFormSheet({
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
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
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
      child: Form(
        key: formKey,
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
                isEditing ? 'income_form_edit_title'.tr() : 'income_form_add_title'.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              AppSizes.l.verticalSpace,

              // Title field
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'income_form_field_name'.tr(),
                  hintText: 'income_form_field_name_hint'.tr(),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.title_rounded),
                ),
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'income_form_field_name_error'.tr() : null,
              ),
              AppSizes.m.verticalSpace,

              // Amount field
              TextFormField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'income_form_field_amount'.tr(),
                  hintText: '0.00',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.payments_rounded),
                  suffixText: 'currency_egp_short'.tr(),
                ),
                validator: (v) {
                  final n = double.tryParse(v ?? '');
                  return (n == null || n <= 0) ? 'income_form_field_amount_error'.tr() : null;
                },
              ),
              AppSizes.m.verticalSpace,

              // Description field
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'income_form_field_description'.tr(),
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.notes_rounded),
                ),
              ),
              AppSizes.l.verticalSpace,

              // Category selector
              Text(
                'income_form_category_label'.tr(),
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
                  itemCount: IncomeCategories.values.length,
                  separatorBuilder: (_, _) => 10.horizontalSpace,
                  itemBuilder: (context, index) {
                    final category = IncomeCategories.values[index];
                    final key = category.key;
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
                            category.label,
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
                          'income_form_delete_btn'.tr(),
                          style: const TextStyle(color: AppColors.error),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onSave,
                      child: Text(isEditing ? 'income_form_update_btn'.tr() : 'income_form_save_btn'.tr()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
