import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/shared/widgets/loaders/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
                borderRadius: BorderRadius.circular(sizes.borderRadius.large),
              ),
              child: Hero(
                tag:'product_image_${product.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(sizes.borderRadius.large),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return Padding(
                        padding: EdgeInsets.all(sizes.borderRadius.small),
                        child: child,
                      );
                      }
                      return  Center(
                        child: AppLoader(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image_outlined, color: AppColors.greyText),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height:sizes.spacing.small),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.p6Medium(color: AppColors.darkText),
                ),
                SizedBox(height:sizes.spacing.small),
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: AppTextStyles.b2Medium(color: AppColors.darkText).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}