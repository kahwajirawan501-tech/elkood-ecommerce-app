import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  final _Spacing spacing = _Spacing();
  final _Padding padding = _Padding();
  final _BorderRadius borderRadius = _BorderRadius();
  final _Icons icons = _Icons();
  final _Buttons buttons = _Buttons();

}

class _Spacing {
  final double tiny = 4.r;
  final double small = 8.r;
  final double medium = 12.r;
  final double large = 16.r;
  final double extraLarge = 24.r;
}

class _Padding {
  final double screenHorizontal = 32.r;
  final double screenVertical = 16.r;
  final double field = 18.r;
}

class _BorderRadius {
  final double small = 8.r;
  final double medium = 12.r;
  final double large = 16.r;
  final double extraLarge = 50.r;
}

class _Icons {
  final double small = 16;
  final double medium = 24;
}

class _Buttons {
  final double height = 57.r;
}