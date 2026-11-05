import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/widgets/custom_app_bar.dart';
import 'package:masrofy/features/expenses/models/expense_entry_model.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/months.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../../../core/extensions/widget_extension.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../expenses/controller/expense_controller.dart';
import '../../../expenses/models/expnese_category.dart';
import '../../../expenses/view/widgets/add_expense.dart';
import '../../../expenses/view/widgets/months_list.dart';

class ExpensesTab extends ConsumerStatefulWidget {
  const ExpensesTab({super.key});

  @override
  ConsumerState<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends ConsumerState<ExpensesTab> {
  int _selMonth = DateTime.now().month;
  int _selYear = DateTime.now().year;

  String formatDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) {
      return 'اليوم';
    } else if (checkDate == yesterday) {
      return 'أمس';
    } else {
      return DateFormat('d MMMM yyyy', 'ar').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final expensesController = ref.watch(expenseControllerProvider);
    final isDark = context.isDarkMode;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(
            showBackButton: false,
            title: 'المصروفات',
            addNewItem: () => AddExpenseBottomSheet.show(context),
          ).center(),
          AppSizes.m.verticalSpace,
          expensesController.when(
            data: (data) {
              ///------------
              final filtered = data
                  .where((e) => e.month == _selMonth && e.year == _selYear)
                  .toList();
              filtered.sort((a, b) => b.date.compareTo(a.date));

              ///------------
              final total = filtered.fold<double>(
                0,
                (sum, e) => sum + e.amount,
              );

              ///------------
              final monthYearKeys = {
                '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}',
                ...data.map((e) => e.monthYear),
              }.toList()..sort((a, b) => b.compareTo(a));

              ///------------
              final Map<String, List<ExpenseEntryModel>> groupsData = {};
              for (final item in filtered) {
                final date = formatDateLabel(item.date);
                if (!groupsData.containsKey(date)) {
                  groupsData[date] = [];
                }
                groupsData[date]!.add(item);
              }
              // {
              //   "اليوم": [
              //     شراء بقالة (150 EGP),
              //     عشاء (200 EGP)
              //   ],
              //   "أمس": [
              //     بنزين (300 EGP)
              //   ]
              // }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Summary Card
                  _ExpensesSummaryCard(
                    total: total.toString(),
                    monthLabel: '${months[_selMonth - 1]} $_selYear',
                  ),
                  AppSizes.l.verticalSpace,
                  MonthSelector(
                    monthYearKeys: monthYearKeys,
                    selectedMonth: _selMonth,
                    selectedYear: _selYear,
                    activeColor: AppColors.expense,
                    onMonthSelected: (int month, int year) {
                      setState(() {
                        _selMonth = month;
                        _selYear = year;
                      });
                    },
                  ),
                  AppSizes.l.verticalSpace,
                  if (filtered.isEmpty)
                    Column(
                      children: [
                        AppSizes.xxl.verticalSpace,
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: AppSizes.iconXL,
                          color: AppColors.grey400,
                        ),
                        AppSizes.m.verticalSpace,
                        Text(
                          'لا توجد مصروفات مسجلة لهذا الشهر',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                        AppSizes.m.verticalSpace,
                        FilledButton.icon(
                          onPressed: () => AddExpenseBottomSheet.show(context),
                          icon: const Icon(Icons.add_rounded),
                          label: Text('إضافة مصروف'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.expense,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ).center()
                  // List of groups
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: groupsData.keys.length,
                      itemBuilder: (context, index) {
                        final dateLabel = groupsData.keys.elementAt(index);
                        final items = groupsData[dateLabel]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                vertical: 8.h,
                              ),
                              child: Text(
                                dateLabel,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.cardDark
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.rL,
                                ),
                                border: Border.all(
                                  color: isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight,
                                ),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                separatorBuilder: (context, index) => Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: isDark
                                      ? AppColors.dividerDark
                                      : AppColors.dividerLight,
                                ),
                                itemBuilder: (context, itemIndex) {
                                  final item = items[itemIndex];
                                  return InkWell(
                                    onTap: () {
                                      AddExpenseBottomSheet.show(
                                        context,
                                        entry: item,
                                      );
                                    },
                                    child: _TransactionItem(
                                      expenseEntryModel: item,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              );
            },

            error: (err, stack) => Text(
              "تعذر تحميل المصروفات",
              style: context.textTheme.bodyMedium,
            ).center().paddingAll(AppSizes.xl),
            loading: () => const CircularProgressIndicator.adaptive()
                .center()
                .paddingAll(AppSizes.xl),
          ),
        ],
      ).paddingAll(AppSizes.screenPadding),
    );
  }
}

class _ExpensesSummaryCard extends StatelessWidget {
  final String total;
  final String monthLabel;

  const _ExpensesSummaryCard({required this.total, required this.monthLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSizes.m.allPadding,
      decoration: BoxDecoration(
        gradient: AppColors.walletGradient,
        borderRadius: AppSizes.rXL.radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'اجمالى المصروفات',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSizes.xs.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(total, style: context.textTheme.headlineMedium),
                  AppSizes.s.horizontalSpace,
                  Text('EGP', style: context.textTheme.titleMedium),
                ],
              ),
              AppSizes.m.verticalSpace,
              // Period selection pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppSizes.rM.radius,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: AppSizes.iconXS,
                    ),
                    AppSizes.xs.horizontalSpace,
                    Text(monthLabel, style: context.textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ).expanded(),
          AppSizes.s.horizontalSpace,
          Image.asset(
            AppAssets.goals,
            width: 120.w,
            height: 120.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final ExpenseEntryModel expenseEntryModel;

  const _TransactionItem({required this.expenseEntryModel});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final category = ExpenseCategory.getById(expenseEntryModel.category);

    ///final categoryName = category.nameAr;
    final timeStr = DateFormat('jm', 'ar').format(expenseEntryModel.date);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.m, vertical: 12.h),
      child: Row(
        children: [
          // Right side: Icon + Text info
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: category.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  category.icon,
                  color: category.color,
                  size: AppSizes.iconS,
                ),
              ),
              AppSizes.m.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expenseEntryModel.title,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    expenseEntryModel.description,
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

          const Spacer(),

          // Middle: Time
          Text(
            timeStr,
            style: context.textTheme.bodySmall?.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),

          const Spacer(),

          // Left: Amount
          Text(
            '${expenseEntryModel.amount} EGP',
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColors.expense,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/*
    final List<Map<String, dynamic>> groups = [
      {
        'date': 'اليوم',
        'items': [
          {
            'title': 'مطعم',
            'subtitle': 'غداء مع الأصدقاء',
            'time': '12:30 م',
            'amount': '180',
            'icon': Icons.restaurant_rounded,
            'iconColor': AppColors.expense,
            'isHighlighted': true,
          },
          {
            'title': 'مواصلات',
            'subtitle': 'مترو',
            'time': '08:15 ص',
            'amount': '20',
            'icon': Icons.directions_car_rounded,
            'iconColor': AppColors.blue,
            'isHighlighted': false,
          },
          {
            'title': 'قهوة',
            'subtitle': 'ستاربكس',
            'time': '07:45 ص',
            'amount': '45',
            'icon': Icons.local_cafe_rounded,
            'iconColor': AppColors.orange,
            'isHighlighted': false,
          },
          {
            'title': 'تسوق',
            'subtitle': 'من السوبر ماركت',
            'time': '06:30 م',
            'amount': '215',
            'icon': Icons.shopping_bag_rounded,
            'iconColor': AppColors.success,
            'isHighlighted': false,
          },
        ],
      },
      {
        'date': 'أمس',
        'items': [
          {
            'title': 'فواتير',
            'subtitle': 'فاتورة الكهرباء',
            'time': '4:30 م',
            'amount': '350',
            'icon': Icons.electric_bolt_rounded,
            'iconColor': AppColors.purple,
            'isHighlighted': true,
          },
          {
            'title': 'تسوق',
            'subtitle': 'ملابس',
            'time': '2:15 م',
            'amount': '320',
            'icon': Icons.shopping_bag_rounded,
            'iconColor': AppColors.success,
            'isHighlighted': false,
          },
        ],
      },
    ];
 */
