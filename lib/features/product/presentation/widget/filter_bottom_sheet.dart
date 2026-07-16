import 'package:e_commerce/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/cubit.dart';

class ProductFilterBottomSheet extends StatefulWidget {
  const ProductFilterBottomSheet({super.key});

  @override
  State<ProductFilterBottomSheet> createState() => _ProductFilterBottomSheetState();
}

class _ProductFilterBottomSheetState extends State<ProductFilterBottomSheet> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProductCubit>();
    _currentRangeValues = RangeValues(
      cubit.minPrice ?? 0.0,
      cubit.maxPrice ?? 300.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(sizes.borderRadius.large),
          topRight: Radius.circular(sizes.borderRadius.large),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: sizes.padding.screenHorizontal,
        vertical:sizes.padding.screenVertical,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filters",
                style: AppTextStyles.h3(),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close_rounded, color: AppColors.darkText,),
              ),
            ],
          ),
          SizedBox(height: sizes.spacing.extraLarge),

          Text(
            "Price Range",
            style: AppTextStyles.b1Medium(color: AppColors.darkText).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: sizes.spacing.extraLarge),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriceLabel("Min Price", "\$${_currentRangeValues.start.round()}"),
              _buildPriceLabel("Max Price", "\$${_currentRangeValues.end.round()}"),
            ],
          ),
          SizedBox(height: sizes.spacing.large),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.lightBackground,
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withOpacity(0.15),
              rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: RangeSlider(
              values: _currentRangeValues,
              min: 0.0,
              max: 300.0,
              divisions: 60,
              labels: RangeLabels(
                "\$${_currentRangeValues.start.round()}",
                "\$${_currentRangeValues.end.round()}",
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
          ),
          SizedBox(height: sizes.spacing.large),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<ProductCubit>().clearFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: const BorderSide(color: AppColors.lightBackground, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Text(
                    "Reset",
                    style: AppTextStyles.b2Medium(color: AppColors.greyText),
                  ),
                ),
              ),
              SizedBox(width: sizes.spacing.large),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ProductCubit>().updatePriceFilter(
                      min: _currentRangeValues.start,
                      max: _currentRangeValues.end,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  child: Text(
                    "Apply Filters",
                    style: AppTextStyles.b2Medium(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceLabel(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.p7Regular(color: AppColors.greyText)),
          SizedBox(height: 4.h),
          Text(value, style: AppTextStyles.b2Medium(color: AppColors.darkText).copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}