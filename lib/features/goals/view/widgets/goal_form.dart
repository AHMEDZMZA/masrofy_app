import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/extensions/widget_extension.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';

class GoalForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isEditing;
  final TextEditingController titleController;
  final TextEditingController currentController;
  final TextEditingController targetController;
  final VoidCallback? onDelete;
  final VoidCallback onSave;

  const GoalForm({
    super.key,
    required this.formKey,
    required this.isEditing,
    required this.titleController,
    required this.currentController,
    required this.targetController,
    required this.onDelete,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
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
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : AppColors.grey300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ).center(),
              AppSizes.m.verticalSpace,
              Text(
                isEditing ? 'goals_form_edit_title'.tr() : 'goals_form_add_title'.tr(),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.m.verticalSpace,
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'goals_form_field_name'.tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'goals_form_field_name_error'.tr() : null,
              ),
              AppSizes.m.verticalSpace,
              TextField(
                controller: currentController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'goals_form_field_current'.tr(),
                  border: const OutlineInputBorder(),
                ),
              ),
              AppSizes.m.verticalSpace,
              TextFormField(
                controller: targetController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'goals_form_field_target'.tr(),
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  final n = double.tryParse(v ?? '');
                  return (n == null || n <= 0) ? 'goals_form_field_target_error'.tr() : null;
                },
              ),
              AppSizes.l.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    if (isEditing && onDelete != null)
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: onDelete,
                          child: Text('goals_form_delete_btn'.tr()),
                        ),
                      ),
                    FilledButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          onSave();
                        }
                      },
                      child: Text(isEditing ? 'goals_form_update_btn'.tr() : 'goals_form_save_btn'.tr()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
