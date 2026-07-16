import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:e_commerce/features/cart/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/cart/presentation/cubit/state.dart';
import 'package:e_commerce/features/cart/presentation/widget/unsave_cart_item_card.dart';
import 'package:e_commerce/shared/widgets/buttons/app_button.dart';
import 'package:e_commerce/shared/widgets/toast/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnsavedCartView extends StatelessWidget {
  const UnsavedCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppSizes sizes = AppSizes();

    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddCartLoaded) {
          showToast(text: "Save Cart Successful", state: ToastStates.SUCCESS);
        } else if (state is GetCartsError) {
          showToast(text: state.message, state: ToastStates.SUCCESS);
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {


          final cartItems = context.read<CartCubit>().localCartItems;

          if (cartItems.isEmpty) return const Center(child: Text("Cart is empty"));

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal:16.r, vertical: sizes.spacing.large),
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) => SizedBox(height: sizes.spacing.medium),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return buildCartItemCard(
                        item: item,
                        onDelete: () => context.read<CartCubit>().removeFromLocalCart(item.product),
                        onQuantityChanged: (newQty) => context.read<CartCubit>().updateLocalQuantity(item.product, newQty),
                      );
                    }
                ),
              ),

              Padding(
                  padding: EdgeInsets.all(sizes.padding.screenHorizontal),
                  child: AppButton(
                    title: "Save Cart",
                    type: AppButtonType.primary,
                    isLoading: state is CartLoading,
                    onPressed: () {
                      context.read<CartCubit>().saveCartToServer();
                    },
                  )
              ),
            ],
          );
        },

      ),
    );
  }
}