import 'package:e_commerce/features/product/domain/entities/product_entity.dart';

class LocalCartItemEntity {
  final ProductEntity product;
  int quantity;

  LocalCartItemEntity({required this.product, required this.quantity});
}