import 'package:e_commerce/features/product/domain/entities/product_entity.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';

class GetProductsUsesCase {
  final ProductRepository productRepository;
  GetProductsUsesCase(this.productRepository);
  Future<List<ProductEntity>>call(){
    return productRepository.getAllProducts();
}
}