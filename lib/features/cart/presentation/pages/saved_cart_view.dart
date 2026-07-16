import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:e_commerce/features/cart/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/cart/presentation/cubit/state.dart';
import 'package:e_commerce/features/cart/presentation/widget/saved_cart_item_card.dart';
import 'package:e_commerce/shared/widgets/loaders/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SavedCartView extends StatefulWidget {
  const SavedCartView({super.key});

  @override
  State<SavedCartView> createState() => _SavedCartViewState();
}

class _SavedCartViewState extends State<SavedCartView> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().fetchAllCarts();
  }
  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();


    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child:AppLoader());
        }

        if (state is GetCartsError) {
          return Center(child: Text("Error: ${state.message}"));
        }


        if (state is GetCartsLoaded) {
          if (state.cart.isEmpty) return const Center(child: Text("No saved carts."));
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal:16.r, vertical: sizes.spacing.large),
            itemCount: state.cart.length,
            separatorBuilder: (_, __) => SizedBox(height: sizes.spacing.medium),
            itemBuilder: (context, index) {
              return SavedCartItemCard(
                cart: state.cart[index],
                index: index,
              );
            },   );
        }
        return const SizedBox.shrink();
      },
    );
  }
}