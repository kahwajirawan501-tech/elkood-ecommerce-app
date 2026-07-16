import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/loaders/app_loader.dart';

enum AppButtonType {
  primary,
  text,
}

class AppButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool fullWidth;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    this.title,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.fullWidth = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();
    final double buttonHeight = height ?? sizes.buttons.height;

    if (type == AppButtonType.text) {
      return SizedBox(
        width: fullWidth ? double.infinity : width,
        height: buttonHeight,
        child: TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: AppColors.primary,
            overlayColor: Colors.transparent,
          ),
          child: _content(),
        ),
      );
    }

    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.lightBackground,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sizes.borderRadius.large),
          ),
        ),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    if (isLoading) {
      return AppLoader();
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: type == AppButtonType.primary
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty)
            Text(
              title!,
              style: AppTextStyles.b1Medium(
                color: type == AppButtonType.primary
                    ? AppColors.white
                    : AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}