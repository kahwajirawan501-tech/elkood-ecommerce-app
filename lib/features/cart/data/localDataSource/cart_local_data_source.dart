import 'dart:convert';
import 'package:e_commerce/features/cart/domain/entities/local_cart_item_entity.dart'; // تأكدي من المسار
import 'package:e_commerce/features/product/domain/entities/product_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class CartLocalDataSource {
  Future<void> saveLocalCart(List<LocalCartItemEntity> items);
  Future<List<LocalCartItemEntity>> getLocalCart();
  Future<void> clearLocalCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final FlutterSecureStorage storage;
  CartLocalDataSourceImpl(this.storage);

  @override
  Future<void> saveLocalCart(List<LocalCartItemEntity> items) async {
    final List<Map<String, dynamic>> jsonList = items.map((item) {
      return {
        'product': {
          'id': item.product.id,
          'title': item.product.title,
          'price': item.product.price,
          'description': item.product.description,
          'category': item.product.category,
          'image': item.product.image,
        },
        'quantity': item.quantity,
      };
    }).toList();

    await storage.write(key: 'local_cart', value: jsonEncode(jsonList));
  }

  @override
  Future<List<LocalCartItemEntity>> getLocalCart() async {
    final String? data = await storage.read(key: 'local_cart');
    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);

    return decoded.map((item) {
      final p = item['product'];
      return LocalCartItemEntity(
        product: ProductEntity(
          id: p['id'],
          title: p['title'],
          price: (p['price'] as num).toDouble(),
          description: p['description'],
          category: p['category'],
          image: p['image'],
        ),
        quantity: item['quantity'], // نسترجع الكمية هنا
      );
    }).toList();
  }

  @override
  Future<void> clearLocalCart() async {
    await storage.delete(key: 'local_cart');
  }
}