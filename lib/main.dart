import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/features/auth/presentation/pages/login_page.dart';
import 'package:e_commerce/features/cart/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/cart/presentation/pages/cart_page.dart';
import 'package:e_commerce/features/product/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/profile/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<CartCubit>()),
            BlocProvider(create: (context) => sl<ProductCubit>()),
            BlocProvider(create: (context) => sl<ProfileCubit>()),

          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}


