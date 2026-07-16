import 'package:e_commerce/core/di/service_locator.dart';
import 'package:e_commerce/features/cart/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/cart/presentation/cubit/state.dart';
import 'package:e_commerce/features/cart/presentation/pages/cart_page.dart';
import 'package:e_commerce/features/product/presentation/pages/product_details_page.dart';
import 'package:e_commerce/features/product/presentation/widget/filter_bottom_sheet.dart';
import 'package:e_commerce/features/profile/presentation/cubit/cubit.dart';
import 'package:e_commerce/features/profile/presentation/cubit/state.dart';
import 'package:e_commerce/shared/widgets/drawers/home_drawer.dart';
import 'package:e_commerce/shared/widgets/loaders/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widget/product_card.dart';
import '../../../../shared/widgets/inputs/app_search_field.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  @override
  void dispose() {

    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = sl<AppSizes>();
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getUserData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: const HomeDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizes.padding.screenHorizontal, vertical: sizes.spacing.extraLarge),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap:() {
                      _searchFocusNode.unfocus();
                      _scaffoldKey.currentState?.openDrawer();
                    }
                        , child:
                    Container(width:sizes.borderRadius.extraLarge, height:sizes.borderRadius.extraLarge,
                        decoration: const BoxDecoration(color: AppColors.lightBackground, shape: BoxShape.circle),
                        child: Icon(Icons.menu_rounded, size:sizes.icons.medium,color: AppColors.darkText))),
                    GestureDetector(
                      onTap: () {
                        _searchFocusNode.unfocus();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: sizes.borderRadius.extraLarge,
                            height: sizes.borderRadius.extraLarge,
                            decoration: const BoxDecoration(
                              color: AppColors.lightBackground,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: sizes.icons.medium,
                              color: AppColors.darkText,
                            ),
                          ),

                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              final cubit = context.read<CartCubit>();

                              if (cubit.hasUnsavedChanges) {
                                return Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: 12.r,
                                    height: 12.r,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.padding.screenHorizontal),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<ProfileCubit, ProfileState>(
                              builder: (context, state) {
                                String welcomeText = "Welcome back!";
                                if (state is ProfileLoaded) welcomeText = state.user.name.firstname;
                                return Text(welcomeText, style: AppTextStyles.h1());
                              },
                            ),
                            SizedBox(height: sizes.spacing.small),
                            Text("Find your unique style today!", style: AppTextStyles.p5Regular(color: AppColors.greyText)),
                            SizedBox(height: sizes.spacing.large),
                          ],
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: sizes.padding.screenVertical),
                          child: Row(
                            children: [
                              Expanded(child: SizedBox(height: 50, child: AppSearchField(
                                  controller: _searchController,
                                  focusNode: _searchFocusNode,
                                  hint: "Search...",
                                  onChanged: (value) => context.read<ProductCubit>().updateSearchQuery(value)))),
                              SizedBox(width: sizes.spacing.small),
                              GestureDetector(
                                onTap: () {
                                  _searchFocusNode.unfocus();
                                  showModalBottomSheet(context: context,
                                      isScrollControlled: true, backgroundColor: Colors.transparent,
                                      builder: (_) => BlocProvider.value(value: context.read<ProductCubit>(),
                                          child: const ProductFilterBottomSheet()));
                                }
                                    ,
                                child: Container(width: sizes.buttons.height-6, height: sizes.buttons.height-6, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(sizes.borderRadius.large)), child: const Icon(Icons.tune_rounded, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(child: Padding(padding: EdgeInsets.only(bottom: sizes.padding.screenVertical), child: Text("What's Hot Now", style: AppTextStyles.p4Medium(color: AppColors.darkText).copyWith(fontWeight: FontWeight.w700)))),

                      BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) return const SliverFillRemaining(child: Center(child: AppLoader()));
                          if (state is ProductLoaded) {
                            return SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: isLandscape ? 4 : 2, mainAxisSpacing: 16.h, crossAxisSpacing: 16.w, childAspectRatio: 0.65),
                              delegate: SliverChildBuilderDelegate((context, index) =>
                                  ProductCard(product: state.products[index],
                                      onTap: () {
                                        _searchFocusNode.unfocus();
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            ProductDetailsPage(product: state.products[index])));
                                      },
                                          ), childCount: state.products.length),
                            );
                          }
                          return const SliverToBoxAdapter(child: SizedBox());
                        },
                      ),
                    ],
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