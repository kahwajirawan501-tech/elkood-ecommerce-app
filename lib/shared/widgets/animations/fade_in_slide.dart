import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FadeInSlide extends StatelessWidget {
  final Widget child;
  final int delay; // بالملي ثانية

  const FadeInSlide({super.key, required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      // تأخير الأنيميشن
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 30.h), // حركة من الأسفل للأعلى
            child: child,
          ),
        );
      },
      // إضافة التأخير هنا عبر الـ duration في الـ animation إذا أردتِ
      // أو ببساطة استخدمي Widget أخرى إذا أردتِ تأخيراً دقيقاً
      child: child,
    );
  }
}