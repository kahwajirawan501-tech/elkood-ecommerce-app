import 'package:e_commerce/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:e_commerce/features/cart/data/localDataSource/cart_local_data_source.dart';
import 'package:e_commerce/features/cart/domain/entities/cart_entity.dart';
import 'package:e_commerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:e_commerce/features/cart/domain/entities/local_cart_item_entity.dart';
import 'package:e_commerce/features/cart/domain/usecases/add_cart_usecase.dart';
import 'package:e_commerce/features/cart/domain/usecases/get_all_carts_usecase.dart';
import 'package:e_commerce/features/cart/presentation/cubit/state.dart';
import 'package:e_commerce/features/product/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final AddCartUseCase addCartUseCase;
  final GetAllCartsUseCase getAllCartsUseCase;
  final CartLocalDataSource localDataSource;
  final AuthLocalDataSource authLocalDataSource;

  List<LocalCartItemEntity> localCartItems = [];

  CartCubit(
      this.addCartUseCase,
      this.getAllCartsUseCase,
      this.localDataSource,
      this.authLocalDataSource
      ) : super(CartInitial()) {
    _loadCartFromStorage();
  }
  bool hasUnsavedChanges = false;

  void checkUnsavedChanges() {
    hasUnsavedChanges = localCartItems.isNotEmpty;
  }
  Future<void> _loadCartFromStorage() async {
    localCartItems = await localDataSource.getLocalCart();
    if (localCartItems.isNotEmpty) {
      emit(AddLocalCartLoaded(_createCartEntities()));
    }
  }

  Future<void> addToLocalCart(ProductEntity product, int quantity) async {
    emit(CartLoading());
    try {
      final index = localCartItems.indexWhere((item) => item.product.id == product.id);

      if (index != -1) {
        localCartItems[index].quantity += quantity;
      } else {
        localCartItems.add(LocalCartItemEntity(product: product, quantity: quantity));
      }
      checkUnsavedChanges();
      await localDataSource.saveLocalCart(localCartItems);

      emit(AddLocalCartLoaded(_createCartEntities()));
    } catch (e) {
      emit(AddLocalCartError("Failed to add to cart: ${e.toString()}"));
    }
  }
  List<CartEntity> _createCartEntities() {
    return [
      CartEntity(
        userId: 0,
        date: DateTime.now().toString().split(' ')[0],
        items: localCartItems.map((localItem) => CartItemEntity(
            productId: localItem.product.id,
            quantity: localItem.quantity
        )).toList(),
      )
    ];
  }
  Future<void> updateLocalQuantity(ProductEntity product, int newQuantity) async {
    final index = localCartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      if (newQuantity <= 0) {
        localCartItems.removeAt(index);
      } else {
        localCartItems[index].quantity = newQuantity;
      }
      checkUnsavedChanges();
      await localDataSource.saveLocalCart(localCartItems);
      emit(AddLocalCartLoaded(_createCartEntities()));
    }
  }
  Future<void> saveCartToServer() async {
    emit(CartLoading());
    final userId = await authLocalDataSource.getIdUser();

    if (userId == null) {
      emit(GetCartsError("User not logged in"));
      return;
    }

    final itemsForServer = localCartItems.map((localItem) => CartItemEntity(
        productId: localItem.product.id,
        quantity: localItem.quantity
    )).toList();

    final cartEntity = CartEntity(
      userId: userId,
      date: DateTime.now().toString().split(' ')[0],
      items: itemsForServer,
    );
    final result = await addCartUseCase(cart: cartEntity);


      localCartItems.clear();
      await localDataSource.clearLocalCart();
    checkUnsavedChanges();
      emit(AddCartLoaded(result));

  }
  Future<void> fetchAllCarts() async {
    emit(CartLoading());
    try {
      final allCarts = await getAllCartsUseCase();

      final currentUser = await authLocalDataSource.getUser();

      if (currentUser != null) {
        final myCarts = allCarts.where((cart) => cart.userId == currentUser.id).toList();

        emit(GetCartsLoaded(myCarts));
      } else {
        emit(GetCartsError("User not found, please login again"));
      }
    } catch (e) {
      emit(GetCartsError(e.toString()));
    }
  }
  Future<void> removeFromLocalCart(ProductEntity product) async {
    emit(CartLoading());
    try {
      final index = localCartItems.indexWhere((item) => item.product.id == product.id);

      if (index != -1) {
        localCartItems.removeAt(index);

        await localDataSource.saveLocalCart(localCartItems);
        checkUnsavedChanges();
        emit(AddLocalCartLoaded(_createCartEntities()));
      }
    } catch (e) {
      emit(AddLocalCartError("Failed to remove item: ${e.toString()}"));
    }
  }
}