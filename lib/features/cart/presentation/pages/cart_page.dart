import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:e_commerce/features/cart/presentation/pages/saved_cart_view.dart';
import 'package:e_commerce/features/cart/presentation/pages/un_saved_cart_view.dart';
import 'package:e_commerce/shared/widgets/buttons/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,

          leading: Padding(
            padding: EdgeInsets.only(left: 16.r,top: 16.r),
            child: Center(
              child:InkWell(

                  onTap: () => Navigator.pop(context),

                  borderRadius: BorderRadius.circular(sizes.icons.medium),

                  child:AppBackButton()

              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 16.r),
            child: Text("Cart", style: AppTextStyles.h3(color: AppColors.darkText)),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.greyText,
            labelStyle: AppTextStyles.b1Medium(),
            tabs: const [
              Tab(text: "Unsaved"),
              Tab(text: "Saved"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UnsavedCartView(),
            SavedCartView(),
          ],
        ),
      ),
    );
  }
}