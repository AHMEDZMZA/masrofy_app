import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../../core/extensions/widget_extension.dart';
import '../../../../core/themes/app_sizes.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/overview_section.dart';
import '../widgets/quick_tools.dart';
import '../widgets/summery_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isDark: context.isDarkMode,
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeAppBar().paddingAll(AppSizes.s),
            AppSizes.l.verticalSpace,
            SummeryCard().paddingAll(AppSizes.m),
            AppSizes.l.verticalSpace,
            QuickTools(),
            AppSizes.l.verticalSpace,
            OverviewSection(),
          ],
        ),
      ),
    );
  }
}
