import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/extensions/num_extension.dart';
import 'package:masrofy/core/extensions/widget_extension.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';
import 'package:masrofy/features/goals/model/goal_model.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../income/view/pages/income_page.dart';
import '../../controllers/goals_controller.dart';
import '../widgets/goal_card.dart';
import '../widgets/goal_form.dart';
import '../widgets/summery_card.dart';

class GoalsPage extends ConsumerStatefulWidget {
  const GoalsPage({super.key});

  @override
  ConsumerState<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends ConsumerState<GoalsPage> {
  int _selectedTabIndex = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _currentController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///final iconColor = context.colorScheme.onSurface;
    final goalsController = ref.watch(goalsControllerProvider);

    return AppScaffold(
      isDark: context.isDarkMode,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBar(
              title: "الأهداف الماليه",
              addNewItem: _showAddGoalSheet,
            ),
            goalsController.when(
              data: (List<GoalModel> goals) {
                final filteredGoals = _selectedTabIndex == 1
                    ? goals.where((goal) => !goal.isActive).toList()
                    : goals.where((goal) => goal.isActive).toList();
                return Column(
                  children: [
                    GoalsSummaryCard(
                      achieved: goals
                          .where((goal) => !goal.isActive)
                          .length
                          .toString(),
                      total: goals.length.toString(),
                    ),
                    AppSizes.l.verticalSpace,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTabItem('نشطة', index: 0),
                        AppSizes.l.horizontalSpace,
                        _buildTabItem('مكتملة', index: 1),
                      ],
                    ),
                    AppSizes.l.verticalSpace,

                    if (filteredGoals.isEmpty)
                      Center(
                        child: Column(
                          children: [
                            AppSizes.xxl.verticalSpace,
                            Icon(
                              Icons.track_changes_outlined,
                              size: AppSizes.iconXL,
                              color: AppColors.grey400,
                            ),
                            AppSizes.m.verticalSpace,
                            Text(
                              'لا توجد أهداف هنا',
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
                        itemCount: filteredGoals.length,
                        separatorBuilder: (context, index) =>
                            AppSizes.m.verticalSpace,
                        itemBuilder: (context, index) {
                          final goal = filteredGoals[index];
                          return InkWell(
                            onTap: () => _showAddGoalSheet(goal: goal),
                            child: GoalCard(
                              title: goal.title,
                              current: goal.current.toString(),
                              target: goal.target.toString(),
                              percentage: goal.percentage,
                              progressValue: goal.progress,
                              icon: Icons.savings_rounded,
                              color: AppColors.purple,
                            ),
                          );
                        },
                      ),
                    AppSizes.m.verticalSpace,
                  ],
                );
              },
              error: (error, stackTrace) =>
                  Text("تعذر تحميل الاهداف").center().paddingAll(AppSizes.l),
              loading: () => CircularProgressIndicator.adaptive()
                  .center()
                  .paddingAll(AppSizes.l),
            ),
          ],
        ).paddingAll(AppSizes.screenPadding),
      ),
    );
  }

  Widget _buildTabItem(String label, {required int index}) {
    final isSelected = _selectedTabIndex == index;
    final isDark = context.isDarkMode;
    final activeColor = AppColors.purple;

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
  Future<void> _showAddGoalSheet({GoalModel? goal}) async {
    final isEditing = goal != null;
    final formKey = GlobalKey<FormState>();
    _titleController.text = isEditing ? goal.title : "";
    _currentController.text = isEditing ? goal.current.toStringAsFixed(0) : "";
    _targetController.text = isEditing ? goal.target.toStringAsFixed(0) : "";

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GoalForm(
          formKey: formKey,
          isEditing: isEditing,
          titleController: _titleController,
          currentController: _currentController,
          targetController: _targetController,
          onDelete: isEditing
              ? () async {
                  context.pop();
                  await _deleteGoal(goal);
                }
              : null,
          onSave: () {
            if (!formKey.currentState!.validate()) return;
            _onSave(goal: isEditing ? goal : null);
          },
        );
      },
    );
  }

  Future<void> _deleteGoal(GoalModel goal) async {
    try {
      await ref.read(goalsControllerProvider.notifier).deleteGoal(goal.id);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم حذف الهدف بنجاح')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('حدث خطأ اثناء حذف الهدف')));
    }
  }

  Future<void> _onSave({GoalModel? goal}) async {
    final isEditing = goal != null;
    final newGoal = GoalModel(
      id: goal?.id ?? '',
      title: _titleController.text.trim(),
      current: double.tryParse(_currentController.text) ?? 0,
      target: double.tryParse(_targetController.text) ?? 0,
    );
    if (newGoal.title.isEmpty || newGoal.target <= 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('أدخل اسمًا صحيحًا وهدفًا أكبر من صفر')),
      );
      return;
    }
    try {
      final controller = ref.read(goalsControllerProvider.notifier);
      if (!isEditing) {
        await controller.addGoal(newGoal);
      } else {
        await controller.updateGoal(newGoal);
      }
      _currentController.clear();
      _titleController.clear();
      _targetController.clear();
      if (!mounted) return;
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing ? 'تم تعديل الهدف بنجاح' : 'تمت إضافة الهدف بنجاح',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'حدث خطأ أثناء تعديل الهدف'
                : 'حدث خطأ أثناء إضافة الهدف',
          ),
        ),
      );
    }
  }
}
