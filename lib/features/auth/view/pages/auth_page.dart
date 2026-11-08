import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';
import 'package:masrofy/core/widgets/app_scaffold.dart';
import '../../../../core/extensions/widget_extension.dart';
import '../widgets/app_logo.dart';
import '../widgets/auth_btn.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDark = context.isDarkMode;
    return AppScaffold(
      isDark: isDark,
      child: Column(
        children: [
          const Spacer(flex: 2),
          const AppLogo(),
          AppSizes.l.verticalSpace,
          Text(
            'appTitle'.tr(),
            style: context.textTheme.displayLarge?.copyWith(
              color: isDark ? AppColors.white : AppColors.primary,
            ),
          ),
          AppSizes.l.verticalSpace,
          Text(
            'auth_welcome'.tr(),
            style: context.textTheme.titleSmall?.copyWith(
              color: isDark ? AppColors.white : AppColors.primary,
            ),
          ),
          AppSizes.l.verticalSpace,
          Text(
            'auth_subtitle'.tr(),
            style: context.textTheme.titleSmall?.copyWith(
              color: isDark ? AppColors.grey100 : AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          AppSizes.l.verticalSpace,
          const AuthBtn().paddingHorizontal(AppSizes.s),
          const Spacer(),
        ],
      ),
    );
  }
}
