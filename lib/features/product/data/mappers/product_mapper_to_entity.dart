import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';

extension ProductModelMapper on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
    );
  }
}

extension ProductModelListMapper on List<ProductModel> {
  List<ProductEntity> toEntityList() {
    return map((model) => model.toEntity()).toList();
  }
}