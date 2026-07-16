import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:e_commerce/features/product/domain/entities/product_entity.dart';

extension ProductMapperToModel on ProductEntity{
  ProductModel toModel(){
    return ProductModel
      (id: id, title: title, price: price, description: description, category: category, image: image);
  }
}