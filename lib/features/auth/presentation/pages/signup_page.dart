import 'dart:ui';
import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/core/theme/color_background.dart';
import 'package:e_commerce/core/utils/app_validators.dart';
import 'package:e_commerce/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce/shared/widgets/animations/fade_in_slide.dart';
import 'package:e_commerce/shared/widgets/buttons/app_back_button.dart';
import 'package:e_commerce/shared/widgets/buttons/app_button.dart';
import 'package:e_commerce/shared/widgets/inputs/app_text_field.dart';
import 'package:e_commerce/shared/widgets/inputs/auth_switch_text.dart';
import 'package:e_commerce/shared/widgets/toast/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/signup_cubit/cubit.dart';
import '../cubit/signup_cubit/state.dart';

// في حال لم يكن FadeInSlide في ملف منفصل، استورديه من صفحة اللوجن
// import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();

    return BlocProvider(
      create: (_) => sl<SignUpCubit>(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            showToast(text: "Account Created Successfully!", state: ToastStates.SUCCESS);
            Navigator.pop(context);
          } else if (state is SignUpError) {
            showToast(text: state.message, state: ToastStates.SUCCESS);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: Stack(
            children: [
              const AuthBackground(),
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizes.padding.screenHorizontal,
                    vertical: sizes.padding.screenVertical,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: sizes.spacing.extraLarge),

                        FadeInSlide(
                          delay: 0,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(sizes.icons.medium),
                            child:AppBackButton()
                          ),
                        ),

                        SizedBox(height: 0.1.sh),
                        FadeInSlide(
                          delay: 100,
                          child: Text(
                            "Create Account",
                            style: AppTextStyles.h1(),
                          ),
                        ),
                        SizedBox(height: sizes.spacing.small),
                        FadeInSlide(
                          delay: 200,
                          child: Text(
                            "Join us and start shopping",
                            style: AppTextStyles.p5Regular(),
                          ),
                        ),
                        SizedBox(height: sizes.spacing.extraLarge),
                        FadeInSlide(
                          delay: 300,
                          child: AppTextField(
                            label: "Username",
                            controller: usernameController,
                            prefixIcon: Icons.person_outline,
                            validator: AppValidators.username,
                          ),
                        ),
                        SizedBox(height: sizes.spacing.large),
                        FadeInSlide(
                          delay: 400,
                          child: AppTextField(
                            label: "Email Address",
                            controller: emailController,
                            prefixIcon: Icons.alternate_email,
                            validator: AppValidators.email,
                          ),
                        ),
                        SizedBox(height: sizes.spacing.large),
                        FadeInSlide(
                          delay: 500,
                          child: AppTextField(
                            label: "Password",
                            controller: passwordController,
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            validator: AppValidators.password,
                          ),
                        ),
                        SizedBox(height: sizes.spacing.extraLarge),
                        FadeInSlide(
                          delay: 600,
                          child: BlocBuilder<SignUpCubit, SignUpState>(
                            builder: (context, state) {
                              return AppButton(
                                title: "Sign Up",
                                type: AppButtonType.primary,
                                isLoading: state is SignUpLoading,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignUpCubit>().signUp(
                                      id: DateTime.now().millisecondsSinceEpoch,
                                      username: usernameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: sizes.spacing.extraLarge),
                        FadeInSlide(
                          delay: 700,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AuthSwitchText(
                                text: "Already have an account? ",
                                actionText: "Sign In",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}