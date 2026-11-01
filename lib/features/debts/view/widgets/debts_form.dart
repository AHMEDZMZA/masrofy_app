import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';

class DebtFormSheet extends StatelessWidget {
  const DebtFormSheet({
    super.key,
    required this.isDark,
    required this.isEditing,
    required this.titleController,
    required this.creditorController,
    required this.totalController,
    required this.paidController,
    required this.onSave,
    required this.onDelete,
    required this.formKey,
  });

  final bool isDark;
  final GlobalKey<FormState> formKey;
  final bool isEditing;
  final TextEditingController titleController;
  final TextEditingController creditorController;
  final TextEditingController totalController;
  final TextEditingController paidController;
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
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                isEditing ? 'تعديل الدين' : 'إضافة دين جديد',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.m.verticalSpace,
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'عنوان الدين',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'أدخل عنوان الدين' : null,
              ),
              AppSizes.m.verticalSpace,
              TextFormField(
                controller: creditorController,
                decoration: const InputDecoration(
                  labelText: 'الدائن',
                  border: OutlineInputBorder(),
                ),
              ),
              AppSizes.m.verticalSpace,
              TextFormField(
                controller: totalController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'المبلغ الإجمالي',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final total = double.tryParse(v ?? '');
                  if (total == null || total <= 0) {
                    return 'أدخل مبلغًا أكبر من صفر';
                  }
                  return null;
                },
              ),
              AppSizes.m.verticalSpace,
              TextFormField(
                controller: paidController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'المبلغ المسدد',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null; // اختياري
                  final paid = double.tryParse(v);
                  if (paid == null) return 'أدخل رقمًا صحيحًا';
                  if (paid < 0) return 'لا يمكن أن يكون سالبًا';
                  final total = double.tryParse(totalController.text) ?? 0;
                  if (paid > total) return 'المسدد أكبر من الإجمالي';
                  return null;
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
                          child: const Text('حذف الدين'),
                        ),
                      ),
                    FilledButton(
                      onPressed: onSave,
                      child: Text(isEditing ? 'تحديث الدين' : 'حفظ الدين'),
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
