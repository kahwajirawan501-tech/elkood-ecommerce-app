import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:e_commerce/features/cart/domain/entities/cart_entity.dart';

class SavedCartItemCard extends StatelessWidget {
  final CartEntity cart;
  final int index;

  const SavedCartItemCard({super.key, required this.cart, required this.index});

  @override
  Widget build(BuildContext context) {
    final AppSizes sizes = AppSizes();
    int totalQuantity = cart.items.fold(0, (sum, item) => sum + item.quantity);

    return Container(
      padding: EdgeInsets.all(sizes.spacing.medium),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(sizes.borderRadius.large),
      ),
      child: Row(
        children: [
          _buildOrderNumberCircle(index, sizes),
          SizedBox(width: sizes.spacing.medium),
          _buildOrderDetails(cart, sizes),
          _buildQuantityBadge(totalQuantity, sizes),
        ],
      ),
    );
  }

  Widget _buildOrderNumberCircle(int index, AppSizes sizes) {
    return Container(
      width: 50.r,
      height:  50.r,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text("#${index + 1}", style: AppTextStyles.b2Medium(color: AppColors.primary)),
    );
  }

  Widget _buildOrderDetails(CartEntity cart, AppSizes sizes) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order ID: ${cart.userId}", style: AppTextStyles.b2Medium()),
          SizedBox(height: sizes.spacing.tiny),
          Row(
            children: [
              Icon(Icons.calendar_today, size:sizes.icons.small, color: AppColors.greyText),
              SizedBox(width: sizes.spacing.tiny),
              Text(
                (cart.date != null && cart.date!.length >= 10) ? cart.date!.substring(0, 10) : (cart.date ?? ""),
                style: AppTextStyles.b3Regular(color: AppColors.greyText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityBadge(int totalQuantity, AppSizes sizes) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizes.spacing.medium, vertical:sizes.spacing.small,),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(sizes.borderRadius.small),
      ),
      child: Text("$totalQuantity Items", style: AppTextStyles.b3Medium(color: AppColors.darkText)),
    );
  }
}