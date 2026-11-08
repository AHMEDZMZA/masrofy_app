import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofy/core/extensions/build_context.dart';
import 'package:masrofy/core/extensions/num_extension.dart';
import 'package:masrofy/core/extensions/widget_extension.dart';
import 'package:masrofy/core/routes/app_routes.dart';
import 'package:masrofy/core/themes/app_colors.dart';
import 'package:masrofy/core/themes/app_sizes.dart';
import 'package:masrofy/core/themes/theme_mode_provider.dart';
import '../../../../core/service/firebase_service.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../auth/controllers/auth_controller.dart';

class MoreTab extends ConsumerWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final user = ref.watch(firebaseAuthProvider).currentUser;

    return AppScaffold(
      isDark: context.isDarkMode,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('more_title'.tr(), style: context.textTheme.titleLarge),
            AppSizes.s.verticalSpace,
            // Profile Card Header
            _buildProfileCard(context, user),
            AppSizes.l.verticalSpace,

            // Settings section list
            _buildSettingsSection(
              context: context,
              title: 'more_section_appearance'.tr(),
              items: [
                _buildThemeSelectorTile(context, ref, currentThemeMode),
                _buildLanguageSelectorTile(context),
              ],
            ),

            AppSizes.l.verticalSpace,

            _buildSettingsSection(
              context: context,
              title: 'more_section_profile'.tr(),
              items: [_buildLogoutTile(context, ref)],
            ),
          ],
        ).paddingAll(AppSizes.screenPadding),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, User? user) {
    final name = user?.displayName ?? 'more_default_user'.tr();
    final email = user?.email ?? '';
    final photoUrl = user?.photoURL;

    return Container(
      width: double.infinity,
      padding: AppSizes.m.allPadding,
      decoration: BoxDecoration(
        gradient: AppColors.walletGradient,
        borderRadius: AppSizes.rXL.radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
            child: photoUrl == null
                ? Icon(Icons.person_rounded, size: AppSizes.iconXL)
                : null,
          ),
          AppSizes.m.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                email,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ).expanded(),
        ],
      ),
    );
  }
/*
  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSizes.m.allPadding,
      decoration: BoxDecoration(
        gradient: AppColors.walletGradient,
        borderRadius: AppSizes.rXL.radius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // User Avatar Icon / Photo placeholder
          CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            child: Icon(Icons.person_rounded, size: AppSizes.iconXL),
          ),
          AppSizes.m.horizontalSpace,
          // User Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("أحمد كمال", style: context.textTheme.titleMedium),
              SizedBox(height: 4.h),
              Text(
                "zamzam@gmail.com",
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ).expanded(),
        ],
      ),
    );
  }
 */

  Widget _buildSettingsSection({
    required BuildContext context,
    required String title,
    required List<Widget> items,
  }) {
    final isDark = context.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSizes.s.verticalSpace,
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : Colors.white,
            borderRadius: AppSizes.rL.radius,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Column(children: items),
        ),
      ],
    ).paddingAll(AppSizes.s);
  }

  Widget _buildThemeSelectorTile(
    BuildContext context,
    WidgetRef ref,
    ThemeMode currentMode,
  ) {
    final isDark = context.isDarkMode;

    String modeName = 'more_theme_auto'.tr();
    IconData modeIcon = Icons.settings_brightness_rounded;

    if (currentMode == ThemeMode.light) {
      modeName = 'more_theme_light'.tr();
      modeIcon = Icons.light_mode_rounded;
    } else if (currentMode == ThemeMode.dark) {
      modeName = 'more_theme_dark'.tr();
      modeIcon = Icons.dark_mode_rounded;
    }

    return ListTile(
      leading: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: AppSizes.iconXS,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      ),
      title: Row(
        children: [
          Text(
            'more_theme_change'.tr(),
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ).expanded(),
          AppSizes.m.horizontalSpace,
          Text(
            modeName,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      trailing: Container(
        padding: AppSizes.s.allPadding,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(modeIcon, color: AppColors.primary, size: AppSizes.iconS),
      ),
      onTap: () => _showThemeSelectionSheet(context, ref, currentMode),
    );
  }

  Widget _buildLanguageSelectorTile(BuildContext context) {
    final isDark = context.isDarkMode;
    final currentLocale = context.locale.languageCode;
    final isArabic = currentLocale == 'ar';

    return ListTile(
      leading: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: AppSizes.iconXS,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      ),
      title: Row(
        children: [
          Text(
            'more_language_change'.tr(),
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ).expanded(),
          SizedBox(width: 8.w),
          Text(
            isArabic ? 'more_language_arabic'.tr() : 'more_language_english'.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      trailing: Container(
        padding: AppSizes.s.allPadding,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.language_rounded,
          color: AppColors.primary,
          size: AppSizes.iconS,
        ),
      ),
      onTap: () {
        final targetLocale = isArabic ? const Locale('en') : const Locale('ar');
        context.setLocale(targetLocale);
      },
    );
  }

  Widget _buildLogoutTile(BuildContext context, WidgetRef ref) {
    final isDark = context.isDarkMode;
    return ListTile(
      leading: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: AppSizes.iconXS,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'more_logout'.tr(),
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.error,
          ),
        ),
      ),
      trailing: Container(
        padding: AppSizes.s.allPadding,
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.logout_rounded,
          color: AppColors.error,
          size: 20,
        ),
      ),
      onTap: () async {
        await ref.read(authControllerProvider.notifier).signOut();
        if (context.mounted) context.go(AppRoutes.auth);
      },
    );
  }

  void _showThemeSelectionSheet(
    BuildContext context,
    WidgetRef ref,
    ThemeMode currentMode,
  ) {
    final isDark = context.isDarkMode;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Bottom sheet drag handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'more_theme_change'.tr(),
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildThemeOption(
                context: context,
                ref: ref,
                title: 'more_theme_auto'.tr(),
                mode: ThemeMode.system,
                selected: currentMode == ThemeMode.system,
              ),
              const Divider(),
              _buildThemeOption(
                context: context,
                ref: ref,
                title: 'more_theme_light'.tr(),
                mode: ThemeMode.light,
                selected: currentMode == ThemeMode.light,
              ),
              const Divider(),
              _buildThemeOption(
                context: context,
                ref: ref,
                title: 'more_theme_dark'.tr(),
                mode: ThemeMode.dark,
                selected: currentMode == ThemeMode.dark,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required ThemeMode mode,
    required bool selected,
  }) {
    return InkWell(
      onTap: () {
        ref.read(themeModeProvider.notifier).setThemeMode(mode);
        context.pop();
      },
      borderRadius: 12.r.radius,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? AppColors.primary : null,
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary)
            else
              Icon(
                Icons.circle_outlined,
                color: context.isDarkMode
                    ? AppColors.borderDark
                    : AppColors.borderLight,
              ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:masrofy/core/routes/app_routes.dart';
import 'package:masrofy/core/themes/theme_mode_provider.dart';
import '../../../../core/service/firebase_service.dart';
import '../../../auth/controllers/auth_controller.dart';

class MoreTab extends ConsumerWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final user = ref.watch(firebaseAuthProvider).currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('المزيد')),
      body: ListView(
        children: [
          if (user != null)
            ListTile(
              leading: CircleAvatar(
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : null,
                child: user.photoURL == null ? const Icon(Icons.person) : null,
              ),
              title: Text(user.displayName ?? 'userName'.tr()),
              subtitle: Text(user.email ?? 'userEmail'.tr()),
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text("تغيير المظهر"),
            trailing: DropdownButton<ThemeMode>(
              value: currentThemeMode,
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(mode);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('التلقائي'),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text('فاتح')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('داكن')),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('تغيير اللغه'),
            trailing: Text(
              context.locale.languageCode == 'ar' ? 'العربية' : 'English',
            ),
            onTap: () {
              final isArabic = context.locale.languageCode == 'ar';
              context.setLocale(
                isArabic ? const Locale('en') : const Locale('ar'),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(
              'تسجيل الخروج',
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {
              ref.read(authControllerProvider.notifier).signOut();
              context.go(AppRoutes.auth);
            },
          ),
        ],
      ),
    );
  }
}
 */
