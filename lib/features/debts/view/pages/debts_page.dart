import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/extensions/num_extension.dart';
import 'package:masrofy/core/extensions/widget_extension.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';
import 'package:masrofy/features/debts/controllers/debts_controller.dart';
import 'package:masrofy/features/debts/model/debts_model.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/debt_card.dart';
import '../widgets/debts_form.dart';
import '../widgets/debts_summery_card.dart';

class DebtsPage extends ConsumerStatefulWidget {
  const DebtsPage({super.key});

  @override
  ConsumerState<DebtsPage> createState() => _DebtsPageState();
}

class _DebtsPageState extends ConsumerState<DebtsPage> {
  int _selectedTabIndex = 0; // 0: كل الديون, 1: متبقي, 2: مسددة
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _creditorController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _creditorController.dispose();
    _totalController.dispose();
    _paidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///final iconColor = context.colorScheme.onSurface;
    final debtsState = ref.watch(debtsControllerProvider);
    return AppScaffold(
      isDark: context.isDarkMode,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Row
            CustomAppBar(title: 'debts_title'.tr(), addNewItem: _showDebtFormSheet),

            AppSizes.m.verticalSpace,

            debtsState.when(
              data: (List<DebtsModel> debts) {
                final filteredDebts = switch (_selectedTabIndex) {
                  1 => debts.where((d) => !d.isPaid).toList(),
                  2 => debts.where((d) => d.isPaid).toList(),
                  _ => debts,
                };
                final totalRemaining = debts
                    .where((debt) => !debt.isPaid)
                    .fold<double>(0, (sum, debt) => sum + debt.remainingAmount);

                final totalAmount = debts.fold<double>(
                  0,
                  (sum, debt) => sum + debt.totalAmount,
                );

                final paidPercentage = totalAmount == 0
                    ? 0.0
                    : ((totalAmount -
                              debts.fold<double>(
                                0,
                                (sum, debt) => sum + debt.remainingAmount,
                              )) /
                          totalAmount *
                          100);

                return Column(
                  children: [
                    // Red Coral Gradient Card
                    DebtsSummaryCard(
                      totalRemaining: totalRemaining,
                      paidPercentage: paidPercentage,
                    ),
                    AppSizes.l.verticalSpace,

                    // Custom tab bar
                    Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTabItem('debts_tab_all'.tr(), index: 0),
                        _buildTabItem('debts_tab_remaining'.tr(), index: 1),
                        _buildTabItem('debts_tab_paid'.tr(), index: 2),
                      ],
                    ),
                    AppSizes.l.verticalSpace,

                    // List of Debts
                    if (filteredDebts.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            AppSizes.xxl.verticalSpace,
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: AppSizes.iconXL,
                              color: AppColors.grey400,
                            ),
                            AppSizes.m.verticalSpace,
                            Text(
                              'debts_empty'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.grey500,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredDebts.length,
                        separatorBuilder: (context, index) =>
                            AppSizes.m.verticalSpace,
                        itemBuilder: (context, index) {
                          final debt = filteredDebts[index];
                          return DebtCard(
                            debt: debt,
                            onTap: () => _showDebtFormSheet(debt: debt),
                          );
                        },
                      ),
                  ],
                );
              },
              error: (error, stackTrace) =>
                  Text('debts_load_error'.tr()).center().paddingAll(AppSizes.l),
              loading: () => const CircularProgressIndicator.adaptive()
                  .center()
                  .paddingAll(AppSizes.l),
            ),
          ],
        ).paddingAll(AppSizes.screenPadding),
      ),
    );
  }

  Future<void> _showDebtFormSheet({DebtsModel? debt}) async {
    final formKey = GlobalKey<FormState>();
    final isDark = context.isDarkMode;
    final isEditing = debt != null;
    _titleController.text = isEditing ? debt.title : "";
    _creditorController.text = isEditing ? debt.creditor : "";
    _totalController.text = isEditing
        ? debt.totalAmount.toStringAsFixed(0)
        : "";
    _paidController.text = isEditing ? debt.paidAmount.toStringAsFixed(0) : "";

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DebtFormSheet(
          formKey: formKey,
          isDark: isDark,
          isEditing: isEditing,
          titleController: _titleController,
          creditorController: _creditorController,
          totalController: _totalController,
          paidController: _paidController,
          onDelete: isEditing
              ? () async {
                  context.pop();
                  await _deleteDebt(debt);
                }
              : null,
          onSave: () {
            if (!formKey.currentState!.validate()) return;
            _onSave(debt: isEditing ? debt : null);
          },
        );
      },
    );
  }

  Future<void> _deleteDebt(DebtsModel debt) async {
    try {
      await ref.read(debtsControllerProvider.notifier).deleteDebt(debt.id);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('debts_delete_success'.tr())));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('debts_delete_error'.tr())));
    }
  }

  Future<void> _onSave({DebtsModel? debt}) async {
    final isEditing = debt != null;
    final title = _titleController.text.trim();
    final creditor = _creditorController.text.trim();
    final total = double.tryParse(_totalController.text) ?? 0;
    final paid = double.tryParse(_paidController.text) ?? 0;
    if (title.isEmpty || total <= 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('debts_invalid_input'.tr()),
        ),
      );
      return;
    }

    final updatedDebt = DebtsModel(
      id: debt?.id ?? '',
      title: title,
      creditor: creditor,
      totalAmount: total,
      paidAmount: paid,
    );

    try {
      final controller = ref.read(debtsControllerProvider.notifier);
      if (!isEditing) {
        await controller.addDebt(updatedDebt);
      } else {
        await controller.updateDebt(updatedDebt);
      }
      await controller.refreshDebts();

      if (!mounted) return;
      _titleController.clear();
      _creditorController.clear();
      _totalController.clear();
      _paidController.clear();
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing ? 'debts_update_success'.tr() : 'debts_add_success'.tr(),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'debts_update_error'.tr()
                : 'debts_add_error'.tr(),
          ),
        ),
      );
    }
  }

  Widget _buildTabItem(String label, {required int index}) {
    final isSelected = _selectedTabIndex == index;
    final isDark = context.isDarkMode;
    const activeColor = AppColors.expense;

    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.textTheme.titleSmall?.copyWith(
              color: isSelected
                  ? activeColor
                  : (isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          AppSizes.xs.verticalSpace,
          Container(
            width: 70.w,
            height: 2.h,
            decoration: BoxDecoration(
              color: isSelected ? activeColor : Colors.transparent,
              borderRadius: 1.r.radius,
            ),
          ),
        ],
      ),
    );
  }
}
