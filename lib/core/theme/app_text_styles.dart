import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart'; // تأكد من مسار الاستيراد الصحيح لملف الألوان

class AppTextStyles {
  AppTextStyles._();

  // ==========================================
  // === HEADLINE (Height: 110% -> 1.1) ===
  // ==========================================

  static TextStyle h1({Color? color}) => GoogleFonts.inter(
    fontSize: 34.spMin,
    fontWeight: FontWeight.w700, // Bold
    height: 1.1,
    color: color ?? AppColors.darkText,
  );

  static TextStyle h2({Color? color}) => GoogleFonts.inter(
    fontSize: 28.spMin,
    fontWeight: FontWeight.w600, // Semibold
    height: 1.1,
    color: color ?? AppColors.darkText,
  );

  static TextStyle h3({Color? color}) => GoogleFonts.inter(
    fontSize: 22.spMin,
    fontWeight: FontWeight.w500, // Medium
    height: 1.1,
    color: color ?? AppColors.darkText,
  );

  // ==========================================
  // === PARAGRAPH (Height: 140% -> 1.4) ===
  // ==========================================

  static TextStyle p1({Color? color}) => GoogleFonts.inter(
    fontSize: 34.spMin,
    fontWeight: FontWeight.w700, // Bold
    height: 1.4,
    color: color ?? AppColors.darkText,
  );

  static TextStyle p2({Color? color}) => GoogleFonts.inter(
    fontSize: 28.spMin,
    fontWeight: FontWeight.w600, // Semibold
    height: 1.4,
    color: color ?? AppColors.darkText,
  );

  static TextStyle p3({Color? color}) => GoogleFonts.inter(
    fontSize: 22.spMin,
    fontWeight: FontWeight.w500, // Medium
    height: 1.4,
    color: color ?? AppColors.darkText,
  );

  // --- P4 (17px) ---
  static TextStyle p4Medium({Color? color}) => GoogleFonts.inter(
    fontSize: 17.spMin,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: color ?? AppColors.darkText,
  );
  static TextStyle p4Regular({Color? color}) => GoogleFonts.inter(
    fontSize: 17.spMin,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: color ?? AppColors.greyText,
  );

  // --- P5 (15px) ---
  static TextStyle p5Medium({Color? color}) => GoogleFonts.inter(
    fontSize: 15.spMin,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: color ?? AppColors.darkText,
  );
  static TextStyle p5Regular({Color? color}) => GoogleFonts.inter(
    fontSize: 15.spMin,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: color ?? AppColors.greyText,
  );

  // --- P6 (13px) ---
  static TextStyle p6Medium({Color? color}) => GoogleFonts.inter(
    fontSize: 13.spMin,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: color ?? AppColors.darkText,
  );
  static TextStyle p6Regular({Color? color}) => GoogleFonts.inter(
    fontSize: 13.spMin,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: color ?? AppColors.greyText,
  );

  // --- P7 (11px) ---
  static TextStyle p7Medium({Color? color}) => GoogleFonts.inter(
    fontSize: 11.spMin,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: color ?? AppColors.darkText,
  );
  static TextStyle p7Regular({Color? color}) => GoogleFonts.inter(
    fontSize: 11.spMin,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: color ?? AppColors.greyText,
  );

  // ==========================================
  // === BODY (Height: 110% -> 1.1) ===
  // ==========================================

  // --- B1 (17px) ---
  static TextStyle b1Medium({Color? color}) => GoogleFonts.inter(
    fontSize: 17.spMin,
    fontWeight: FontWeight.w500,
    height: 1.1,
    color: color ?? AppColors.darkText,
  );
  static TextStyle b1Regular({Color? color}) => GoogleFonts.inter(
    fontSize: 17.spMin,
    fontWeight: FontWeight.w400,
    height: 1.1,
    color: color ?? AppColors.greyText,
  );

  // --- B2 (15px) ---
  static TextStyle b2Medium({Color? color}) => GoogleFonts.inter(
    fontSize: 15.spMin,
    fontWeight: FontWeight.w500,
    height: 1.1,
    color: color ?? AppColors.darkText,
  );
  static TextStyle b2Regular({Color? color}) => GoogleFonts.inter(
    fontSize: 15.spMin,
    fontWeight: FontWeight.w400,
    height: 1.1,
    color: color ?? AppColors.greyText,
  );

  // --- B3 (13px) ---
  static TextStyle b3Medium({Color? color}) => GoogleFonts.inter(
    fontSize: 13.spMin,
    fontWeight: FontWeight.w500,
    height: 1.1,
    color: color ?? AppColors.darkText,
  );
  static TextStyle b3Regular({Color? color}) => GoogleFonts.inter(
    fontSize: 13.spMin,
    fontWeight: FontWeight.w400,
    height: 1.1,
    color: color ?? AppColors.greyText,
  );

  // --- B4 (11px) ---
  static TextStyle b4Medium({Color? color}) => GoogleFonts.inter(
    fontSize: 11.spMin,
    fontWeight: FontWeight.w500,
    height: 1.1,
    color: color ?? AppColors.darkText,
  );
  static TextStyle b4Regular({Color? color}) => GoogleFonts.inter(
    fontSize: 11.spMin,
    fontWeight: FontWeight.w400,
    height: 1.1,
    color: color ?? AppColors.greyText,
  );
}