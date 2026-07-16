import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce/features/product/domain/usecase/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import 'state.dart'; // تأكدي من مسار state.dart

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUsesCase getProductsUseCase;

  List<ProductEntity> _allProducts = [];

  String _currentQuery = '';
  double? minPrice;
  double? maxPrice;

  ProductCubit(this.getProductsUseCase) : super(ProductInitial());

  Future<void> fetchProducts() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(ProductError("No Internet"));
      return;
    }
    emit(ProductLoading());
    try {
      _allProducts = await getProductsUseCase.call();
      _applyFilters();
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void updateSearchQuery(String query) {
    _currentQuery = query;
    _applyFilters();
  }

  void updatePriceFilter({double? min, double? max}) {
    minPrice = min;
    maxPrice = max;
    _applyFilters();
  }

  void clearFilters() {
    _currentQuery = '';
    minPrice = null;
    maxPrice = null;
    _applyFilters();
  }


  void _applyFilters() {
    if (_allProducts.isEmpty) return;

    final filteredList = _allProducts.where((product) {
      bool matchesText = true;
      if (_currentQuery.trim().isNotEmpty) {
        final lowerCaseQuery = _currentQuery.toLowerCase();
        final matchTitle = product.title.toLowerCase().contains(lowerCaseQuery);
        final matchDescription = product.description.toLowerCase().contains(lowerCaseQuery);
        matchesText = matchTitle || matchDescription;
      }

      bool matchesMinPrice = true;
      if (minPrice != null) {
        matchesMinPrice = product.price >= minPrice!;
      }

      bool matchesMaxPrice = true;
      if (maxPrice != null) {
        matchesMaxPrice = product.price <= maxPrice!;
      }

      return matchesText && matchesMinPrice && matchesMaxPrice;
    }).toList();

    emit(ProductLoaded(filteredList));
  }

  Future<void> checkConnectionAndFetch() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(ProductError("No Internet"));
      return;

    } else {
      fetchProducts();
    }
  }
}