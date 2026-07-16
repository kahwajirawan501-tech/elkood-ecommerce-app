import 'dart:ui';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الدائرة الأولى (الأساسية)
        Positioned(
          top: -50.h,
          left: -50.w,
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // الدائرة الثانية (الثانوية)
        Positioned(
          top: 200.h,
          right: -80.w,
          child: Container(
            width: 250.w,
            height: 250.h,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        // تأثير الضبابية
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(color: Colors.transparent),
        ),
      ],
    );
  }
}