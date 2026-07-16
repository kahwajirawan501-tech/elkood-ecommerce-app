import 'package:e_commerce/features/product/data/datasources/product_remote_data_sources.dart';
import 'package:e_commerce/features/product/data/mappers/product_mapper_to_entity.dart';
import 'package:e_commerce/features/product/domain/entities/product_entity.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl  implements ProductRepository{
  final ProductRemoteDataSource productRemoteDataSource;
  ProductRepositoryImpl(this.productRemoteDataSource);
  @override
  Future<List<ProductEntity>> getAllProducts() async{
    final model=await productRemoteDataSource.getAllProducts();
    return model.toEntityList();
  }

}