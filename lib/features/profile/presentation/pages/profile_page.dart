import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/theme/app_text_styles.dart';
import 'package:e_commerce/features/profile/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/profile/presentation/cubit/state.dart';
import 'package:e_commerce/shared/widgets/buttons/app_back_button.dart';
import 'package:e_commerce/shared/widgets/loaders/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getUserData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading:  Padding(
            padding: EdgeInsetsDirectional.only(start: 16.r,top: 16.r),
            child: Center(child: AppBackButton()),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 16.r),
            child: Text("My Profile", style: AppTextStyles.h3(color: AppColors.darkText)),
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) return const Center(child: AppLoader());
            if (state is ProfileError) return Center(child: Text(state.message));
            if (state is ProfileLoaded) {
              final user = state.user;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 0.12.sw,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Icon(Icons.person, size: 60.r, color: AppColors.primary),
                    ),
                    SizedBox(height:sizes.spacing.medium),
                    Text("${user.name.firstname.toUpperCase()} ${user.name.lastname.toUpperCase()}",
                        style: AppTextStyles.b2Medium()),
                    Text(user.email, style: AppTextStyles.p4Regular(color: AppColors.greyText)),

                    SizedBox(height:sizes.spacing.extraLarge),

                    _buildSectionHeader("Personal Details"),
                    _buildInfoCard([
                      _buildInfoTile(Icons.person_outline, "Username", user.username),
                      _buildInfoTile(Icons.phone_outlined, "Phone", user.phone),
                    ]),

                    SizedBox(height:sizes.spacing.large),

                    _buildSectionHeader("Address"),
                    _buildInfoCard([
                      _buildInfoTile(Icons.location_on_outlined, "City", user.address.city),
                      _buildInfoTile(Icons.home_outlined, "Street", "${user.address.street}, ${user.address.number}"),
                      _buildInfoTile(Icons.markunread_mailbox_outlined, "Zip Code", user.address.zipcode),
                    ]),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 10.h, start: 5.w),
        child: Text(title,overflow:TextOverflow.ellipsis, style: AppTextStyles.p4Medium(color: AppColors.darkText)),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, overflow:TextOverflow.ellipsis,style: AppTextStyles.p5Regular(color: AppColors.greyText)),
      subtitle: Text(value, overflow:TextOverflow.ellipsis,style: AppTextStyles.b2Medium(color: AppColors.darkText)),
    );
  }
}