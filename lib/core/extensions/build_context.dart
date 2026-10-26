import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// الثيم كله (ThemeData).
  /// الاستخدام: الوصول لأي إعداد في الثيم.
  /// مثال: context.theme.primaryColor
  ThemeData get theme => Theme.of(this);

  /// أنماط الخطوط (TextTheme).
  /// الاستخدام: أحجام وأشكال النصوص الجاهزة.
  /// مثال: context.textTheme.titleLarge
  TextTheme get textTheme => theme.textTheme;

  /// ألوان التطبيق (ColorScheme).
  /// الاستخدام: الألوان المتناسقة مع الثيم.
  /// مثال: context.colorScheme.primary
  ColorScheme get colorScheme => theme.colorScheme;

  /// مدير الرسائل (ScaffoldMessengerState).
  /// الاستخدام: إظهار SnackBar.
  /// مثال: context.messenger.showSnackBar(...)
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);

  /// بيانات الشاشة (MediaQueryData).
  /// الاستخدام: حجم الشاشة، الكيبورد، الاتجاه، الـ padding.
  /// مثال: context.mediaQuery.viewInsets.bottom
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// أبعاد الشاشة (Size).
  /// الاستخدام: الطول والعرض معاً.
  /// مثال: context.screenSize
  Size get screenSize => mediaQuery.size;

  /// عرض الشاشة (double).
  /// الاستخدام: تحديد عرض عنصر نسبةً للشاشة.
  /// مثال: context.screenWidth * 0.8
  double get screenWidth => screenSize.width;

  /// طول الشاشة (double).
  /// الاستخدام: تحديد ارتفاع عنصر نسبةً للشاشة.
  /// مثال: context.screenHeight * 0.3
  double get screenHeight => screenSize.height;

  /// هل الوضع داكن؟ (bool).
  /// الاستخدام: تغيير الشكل حسب الوضع.
  /// مثال: context.isDarkMode ? Colors.white : Colors.black
  bool get isDarkMode => theme.brightness == Brightness.dark;
}