import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final double? size;
  final double? iconSize;

  const AppBackButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.onPressed,
    this.size,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();


    return SizedBox(
      width: sizes.borderRadius.extraLarge,
      height: sizes.borderRadius.extraLarge,
      child: ElevatedButton(
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary.withOpacity(0.1),
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: const CircleBorder(),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              size: iconSize ?? sizes.icons.medium,
              color: iconColor ?? AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}