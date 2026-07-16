import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/features/cart/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/cart/presentation/cubit/state.dart';
import 'package:e_commerce/shared/widgets/buttons/app_button.dart';
import 'package:e_commerce/shared/widgets/toast/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/product_entity.dart';
import '../../../../shared/widgets/buttons/app_back_button.dart';
class ProductDetailsPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddLocalCartLoaded) {
          showToast(
              text: "Product added to cart successfully",
              state: ToastStates.SUCCESS
          );
          Navigator.pop(context);
        } else if (state is AddLocalCartError) {
          showToast(
              text: "Failed to add product. Please try again.",
              state: ToastStates.SUCCESS
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        bottomNavigationBar: isLandscape ? null : QuantityAddToCartButton(sizes: sizes,product: product),

        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 350,
                      color: AppColors.lightBackground,
                      padding: EdgeInsets.symmetric(horizontal:sizes.padding.screenHorizontal ,vertical:sizes.padding.screenVertical ),
                      child: Hero(
                        tag: 'product_image_${product.id}',
                        child: Image.network(product.image, fit: BoxFit.contain),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(sizes.padding.screenHorizontal),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.category.toUpperCase(),
                              style: AppTextStyles.p6Medium(color: AppColors.greyText).copyWith(letterSpacing: 1.5)),
                          SizedBox(height:sizes.spacing.medium),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(product.title, style: AppTextStyles.h2(color: AppColors.darkText))),
                              SizedBox(width: sizes.spacing.medium),
                              Text("\$${product.price.toStringAsFixed(2)}", style: AppTextStyles.h2(color: AppColors.primary)),
                            ],
                          ),
                          SizedBox(height:sizes.spacing.extraLarge),
                          Text("Description", style: AppTextStyles.h3(color: AppColors.darkText)),
                          SizedBox(height:sizes.spacing.medium),
                          Text(product.description, style: AppTextStyles.p5Regular(color: AppColors.greyText).copyWith(height: 1.5)),

                        ],
                      ),
                    ),
                    if (isLandscape) ...[
                      QuantityAddToCartButton(sizes: sizes,product: product),
                    ],
                  ],
                ),
              ),
            ),


            PositionedDirectional(
              top: 0,
              start: sizes.padding.screenHorizontal,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: const AppBackButton(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class QuantityAddToCartButton extends StatefulWidget {
  final ProductEntity product;
  final AppSizes sizes;

  const QuantityAddToCartButton({super.key, required this.product, required this.sizes});

  @override
  State<QuantityAddToCartButton> createState() => _QuantityAddToCartButtonState();
}

class _QuantityAddToCartButtonState extends State<QuantityAddToCartButton> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.product.price * quantity;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.sizes.padding.screenHorizontal, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.lightBackground, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() { if (quantity > 1) quantity--; }),
                      icon: const Icon(Icons.remove, color: AppColors.darkText, size: 20),
                    ),
                    Text("$quantity", style: AppTextStyles.b2Medium()),
                    IconButton(
                      onPressed: () => setState(() => quantity++),
                      icon: const Icon(Icons.add, color: AppColors.primary, size: 20),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${totalPrice.toStringAsFixed(2)}",
                style: AppTextStyles.h2(),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return AppButton(
                title: "Add to Cart",
                type: AppButtonType.primary,
                isLoading: state is CartLoading,
                onPressed: () => context.read<CartCubit>().addToLocalCart(widget.product, quantity),
              );
            },
          ),
        ],
      ),
    );
  }
}