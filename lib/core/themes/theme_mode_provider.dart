import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// المتغير اللي بتوصل بيه للـ Notifier من أي شاشة
final themeModeProvider = NotifierProvider<ThemeModeProvider, ThemeMode>(
  () => ThemeModeProvider(),
);

class ThemeModeProvider extends Notifier<ThemeMode> {
  @override
  /// القيمة الأولية: ThemeMode.system (يتبع وضع الموبايل)
  ThemeMode build() {
    return ThemeMode.system;
  }
  /// تحدد الوضع يدوياً (light أو dark أو system)
  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
  /// يبدّل بين الفاتح والداكن
  void toggleThemeMode() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
