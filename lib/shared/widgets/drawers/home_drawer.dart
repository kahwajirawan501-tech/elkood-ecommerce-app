import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:e_commerce/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:e_commerce/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce/features/cart/data/localDataSource/cart_local_data_source.dart';
import 'package:e_commerce/features/profile/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/profile/presentation/cubit/state.dart';

import 'package:e_commerce/features/profile/presentation/pages/profile_page.dart';
import 'package:e_commerce/shared/widgets/toast/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getUserData(),
      child: Drawer(
        width: 280.w,
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return _buildHeader(state);
                },
              ),

              const Divider(thickness: 1, height: 1),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  children: [
                    _buildMenuItem(Icons.person_outline, "Account Information", () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                    }),
                    _buildMenuItem(
                      Icons.logout,
                      "Logout",
                          ()async{
                            final localDataSource = sl<AuthLocalDataSource>();
                            final cartDataSource = sl<CartLocalDataSource>();
                            await cartDataSource.clearLocalCart();
                            await localDataSource.clearToken();
                         showToast(text: "Logged out successfully", state: ToastStates.SUCCESS);
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                    (route) => false,
                              );
                            }                },
                      isLogout: true,
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ProfileState state) {
    String name = "Loading...";
    String email = "...";

    if (state is ProfileLoaded) {
      name = "${state.user.name.firstname} ${state.user.name.lastname}";
      email = state.user.email;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(Icons.person, size: 40, color: AppColors.primary),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.b1Medium(color: AppColors.darkText),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  email,
                  style: AppTextStyles.b3Regular(color: AppColors.greyText),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : AppColors.darkText),
      title: Text(
        title,
        style: AppTextStyles.b2Medium(color: isLogout ? Colors.red : AppColors.darkText),
      ),
      onTap: onTap,
    );
  }
}