import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  final double? size;       // حجم الدائرة
  final Color? color;      // لون الدائرة

  const AppLoader({
    super.key,
    this.size ,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();

    final loaderSize = (size ?? sizes.spacing.extraLarge).w;
    final loaderStroke = 3.w;

    return Center(
      child: SizedBox(
        width: loaderSize,
        height: loaderSize,
        child: CircularProgressIndicator(
          strokeWidth:loaderStroke,
          color: color ?? AppColors.primary,
        ),
      ),
    );
  }
}
