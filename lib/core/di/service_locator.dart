import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/constants/dimensions.dart';
import 'package:e_commerce/core/network/dio_client.dart';
import 'package:e_commerce/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:e_commerce/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:e_commerce/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce/features/auth/domain/usecases/login_usecase.dart';
import 'package:e_commerce/features/auth/domain/usecases/signup_usecase.dart';
import 'package:e_commerce/features/auth/presentation/cubit/login_cubit/cubit.dart';
import 'package:e_commerce/features/auth/presentation/cubit/signup_cubit/cubit.dart';
import 'package:e_commerce/features/cart/data/datasources/cart_remote_data_sources.dart';
import 'package:e_commerce/features/cart/data/localDataSource/cart_local_data_source.dart';
import 'package:e_commerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:e_commerce/features/cart/domain/usecases/add_cart_usecase.dart';
import 'package:e_commerce/features/cart/domain/usecases/get_all_carts_usecase.dart';
import 'package:e_commerce/features/cart/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/product/data/datasources/product_remote_data_sources.dart';
import 'package:e_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:e_commerce/features/product/domain/usecase/get_products_usecase.dart';
import 'package:e_commerce/features/product/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/profile/presentation/cubit/cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setup() async {

  // Local Data Source
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(const FlutterSecureStorage()),

  );
  sl.registerLazySingleton<CartLocalDataSource>(
        () => CartLocalDataSourceImpl(const FlutterSecureStorage()),

  );
  sl.registerLazySingleton<AppSizes>(() => AppSizes());
//! Dio
  sl.registerLazySingleton<Dio>(
        () => DioClient(sl<AuthLocalDataSource>()).dio,
  );
  //! DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl<Dio>()),
  );

  //! Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl<AuthRemoteDataSource>(), sl<AuthLocalDataSource>(),),
  );
////////////////////////////////////////////////////////////////
  //! UseCases  login
  sl.registerLazySingleton(
        () => LoginUseCase(sl<AuthRepository>()),
  );

  //! Cubits login
  sl.registerFactory(
        () => LoginCubit(sl<LoginUseCase>()),
  );
///////////////////////////////////////////////////////////////////
  //! UseCases signup
  sl.registerLazySingleton(
        () => SignupUseCase(sl<AuthRepository>()),
  );

  //! Cubits signup
  sl.registerFactory(
        () => SignUpCubit(sl<SignupUseCase>()),
  );
  //////////////////////////////////////////////////////////////////////////////////
 //product
  //! DataSources
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(sl<Dio>()),
  );

  //! Repository
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
  );
  sl.registerLazySingleton(
        () => GetProductsUsesCase(sl<ProductRepository>()),
  );
  sl.registerFactory(
        () => ProductCubit(sl<GetProductsUsesCase>()),
  );
//////////////////////////////////////////////////////////////////////////////////////////
//cart
  //! DataSources
  sl.registerLazySingleton<CartRemoteDataSources>(
        () => CartRemoteDataSourcesImpl(sl<Dio>()),
  );

  //! Repository
  sl.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(sl<CartRemoteDataSources>()),
  );
  sl.registerLazySingleton(
        () => AddCartUseCase(sl<CartRepository>()),
  );
  sl.registerLazySingleton(
        () => GetAllCartsUseCase(sl<CartRepository>()),
  );
  sl.registerFactory(
        () => CartCubit(sl<AddCartUseCase>(),sl<GetAllCartsUseCase>(),sl<CartLocalDataSource>(),sl<AuthLocalDataSource>()),
  );
sl.registerFactory(() =>ProfileCubit(sl<AuthLocalDataSource>()));
}