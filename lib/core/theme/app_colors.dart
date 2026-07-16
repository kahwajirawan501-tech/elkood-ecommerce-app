import 'package:flutter/material.dart';

/// AppColors: Design System كامل للألوان حسب تصميم Figma
class AppColors {
  AppColors._(); // private constructor

  // === Primary Color ===
  static const Color primary = Color(0xFF9775FA);

  // === Main Palette (Light/Dark Mode) ===
  static const Color darkText = Color(0xFF1D1E20);      // أسود داكن
  static const Color greyText = Color(0xFF8F959E);      // رمادي
  static const Color lightBackground = Color(0xFFF5F6FA); // خلفية فاتحة
  static const Color white = Color(0xFFFFFFFF);         // أبيض



  // === Status Colors  ===
  static const Color error   = Color(0xFFFF5A5F);
  static const Color warning = Color(0xFFFFA726);
  static const Color info    = Color(0xFF087E8B);
  static const Color success = Color(0xFF4CAF50);
}