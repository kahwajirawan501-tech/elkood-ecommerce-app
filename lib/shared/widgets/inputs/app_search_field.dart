import 'package:e_commerce/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/theme/app_text_styles.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;

  final VoidCallback? onTap;
  final bool readOnly;
  final FocusNode? focusNode;
  const AppSearchField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();

    return SizedBox(
      height: sizes.buttons.height,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
         focusNode: focusNode,
        onTap: onTap,
        readOnly: readOnly,

        style: AppTextStyles.b2Medium(),
        decoration: InputDecoration(
          hintText: hint ?? "Search...",
          hintStyle: AppTextStyles.b2Regular(color: AppColors.greyText),

          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.greyText,
          ),

          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: sizes.padding.field,
          ),

          filled: true,
          fillColor: AppColors.lightBackground,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sizes.borderRadius.large),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sizes.borderRadius.large),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(sizes.borderRadius.large),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}