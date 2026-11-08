import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/features/expenses/models/expense_entry_model.dart';
import 'package:masrofy/features/expenses/view/widgets/expense_form.dart';
import '../../controller/expense_controller.dart';

class AddExpenseBottomSheet {
  const AddExpenseBottomSheet._();

  static void show(BuildContext context, {ExpenseEntryModel? entry}) {
    final titleCtrl = TextEditingController(text: entry?.title ?? '');
    final descCtrl = TextEditingController(text: entry?.description ?? '');
    final amountCtrl = TextEditingController(
      text: entry != null ? entry.amount.toStringAsFixed(0) : '',
    );
    String cat = entry?.category ?? 'food';
    int m = entry?.month ?? DateTime.now().month;
    int y = entry?.year ?? DateTime.now().year;
    DateTime d = entry?.date ?? DateTime.now();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sc) => StatefulBuilder(
        builder: (ctx, setState) => Consumer(
          builder: (context, ref, _) => ExpenseFormSheet(
            isDark: ctx.isDarkMode,
            isEditing: entry != null,
            titleController: titleCtrl,
            descriptionController: descCtrl,
            amountController: amountCtrl,
            selectedCategory: cat,
            onCategoryChanged: (val) => setState(() => cat = val),
            onDelete: entry == null
                ? null
                : () async {
                    final messenger = ScaffoldMessenger.of(context);
                    ctx.pop();
                    await ref
                        .read(expenseControllerProvider.notifier)
                        .deleteExpenseEntry(entry.id);
                    messenger.showSnackBar(
                      SnackBar(content: Text('expenses_delete_success'.tr())),
                    );
                  },
            onSave: () async {
              final title = titleCtrl.text.trim();
              final amt =
                  double.tryParse(amountCtrl.text.replaceAll(',', '')) ?? 0;
              final messenger = ScaffoldMessenger.of(ctx);
              if (title.isEmpty || amt <= 0) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('expenses_invalid_input'.tr()),
                  ),
                );
                return;
              }
              final newEntry = ExpenseEntryModel(
                id: entry?.id ?? '',
                title: title,
                description: descCtrl.text.trim(),
                amount: amt,
                date: d,
                month: m,
                year: y,
                category: cat,
              );
              try {
                final n = ref.read(expenseControllerProvider.notifier);
                if (entry != null) {
                  await n.updateExpenseEntry(newEntry);
                } else {
                  await n.addExpenseEntry(newEntry);
                }
                if (context.mounted) ctx.pop();
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      entry != null
                          ? 'expenses_update_success'.tr()
                          : 'expenses_add_success'.tr(),
                    ),
                  ),
                );
              } catch (_) {
                messenger.showSnackBar(
                  SnackBar(content: Text('expenses_save_error'.tr())),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
