
import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:e_commerce/features/cart/domain/entities/local_cart_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildCartItemCard({
  required LocalCartItemEntity item,
  required VoidCallback onDelete,
  required Function(int) onQuantityChanged,
}) {
  final AppSizes sizes = AppSizes();
  double totalPriceForItem = item.product.price * item.quantity;

  return Stack(
    children: [
      Container(
        padding: EdgeInsets.only(top: 34.r,
            bottom: sizes.spacing.medium,right: sizes.spacing.medium,left: sizes.spacing.medium),

        decoration: BoxDecoration(

          color: AppColors.white,

          borderRadius: BorderRadius.circular(sizes.borderRadius.large),

        ),
        child: Row(

          children: [
            _buildProductImage(item.product.image, sizes),
            SizedBox(width: sizes.spacing.medium),
            Expanded(
              child: _buildProductDetails(item, totalPriceForItem, onQuantityChanged, sizes),
            ),
          ],
        ),
      ),
      _buildDeleteButton(onDelete, sizes),
    ],
  );
}

Widget _buildProductImage(String imageUrl, AppSizes sizes) {
  return Container(
    width: 90.r,
    height: 100.r,
    decoration: BoxDecoration(
      color: AppColors.lightBackground,
      borderRadius: BorderRadius.circular(sizes.borderRadius.large),
      image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.contain),
    ),
  );
}

Widget _buildProductDetails(LocalCartItemEntity item, double total, Function(int) onQuantityChanged, AppSizes sizes) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(item.product.title, style: AppTextStyles.b2Medium(), maxLines: 2, overflow: TextOverflow.ellipsis),
      SizedBox(height: sizes.spacing.medium),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("\$${total.toStringAsFixed(2)}", style: AppTextStyles.b2Medium(color: AppColors.primary)),
          _buildQuantityCounter(item.quantity, onQuantityChanged, sizes),
        ],
      ),
    ],
  );
}

Widget _buildQuantityCounter(int quantity, Function(int) onQuantityChanged, AppSizes sizes) {
  return Row(
    children: [
      IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 30),
        icon: Icon(Icons.remove, size: sizes.icons.medium),
        onPressed: quantity > 1 ? () => onQuantityChanged(quantity - 1) : null,
      ),
      Text("$quantity", style: AppTextStyles.b1Medium()),
      IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 30),
        icon: Icon(Icons.add, size: sizes.icons.medium),
        onPressed: () => onQuantityChanged(quantity + 1),
      ),
    ],
  );
}

Widget _buildDeleteButton(VoidCallback onDelete, AppSizes sizes) {
  return PositionedDirectional(
    top: 5.r,
    end: 10.r,
    child: GestureDetector(
      onTap: onDelete,
      child: Container(
        padding: EdgeInsets.all(sizes.spacing.tiny),
        decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(Icons.close, size: sizes.icons.small, color: Colors.red.withOpacity(0.7)),
      ),
    ),
  );
}