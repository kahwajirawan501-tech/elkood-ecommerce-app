import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final bool isPassword;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.isPassword = false, // إذا كانت true سيتم إضافة العين تلقائياً
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // متغير لتتبع حالة إخفاء النص
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // التهيئة المبدئية: إذا كان حقل كلمة مرور، اجعله مخفياً بالبداية
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText, // ربط الإخفاء بالمتغير
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.next,
      validator: widget.validator ?? (value) => value == null || value.isEmpty ? "Please enter ${widget.label}" : null,
      style: AppTextStyles.b2Medium(color: AppColors.darkText),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTextStyles.b2Regular(color: AppColors.greyText),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.hint,
        hintStyle: AppTextStyles.b2Regular(color: AppColors.greyText.withOpacity(0.5)),

        prefixIcon: widget.prefixIcon != null
            ? Icon(widget.prefixIcon, color: AppColors.primary, size: sizes.icons.medium)
            : null,

        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.greyText,
            size: sizes.icons.medium,
          ),
          onPressed: () {
            // تحديث الشاشة لعكس حالة الإخفاء والإظهار
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : widget.suffixIcon != null
            ? Align(
          alignment: Alignment.centerRight,
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: widget.suffixIcon,
        )
            : null,

        filled: true,
        fillColor: AppColors.white,

        contentPadding: EdgeInsets.symmetric(
          vertical: sizes.padding.field,
          horizontal: sizes.padding.field,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizes.borderRadius.medium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizes.borderRadius.medium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizes.borderRadius.medium),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}