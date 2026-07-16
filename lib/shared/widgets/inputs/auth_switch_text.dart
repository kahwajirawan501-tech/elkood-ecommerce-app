import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class AuthSwitchText extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthSwitchText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.b1Regular(),
        children: [
          TextSpan(
            text: actionText,
            style: AppTextStyles.b1Regular().copyWith(
              color: AppColors.primary,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}