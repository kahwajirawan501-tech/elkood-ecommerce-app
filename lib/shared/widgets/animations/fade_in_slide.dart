import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FadeInSlide extends StatefulWidget {
  final Widget child;
  final int delay;

  const FadeInSlide({super.key, required this.child, required this.delay});

  @override
  State<FadeInSlide> createState() => _FadeInSlideState();
}

class _FadeInSlideState extends State<FadeInSlide> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          setState(() {
            _isVisible = true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : const Offset(0, 0.1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}