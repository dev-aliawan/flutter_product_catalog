import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';

class ProductService {
  Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productList = products.map((product) => jsonEncode(product.toJson())).toList();
    prefs.setStringList('products', productList);
  }

  Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productList = prefs.getStringList('products') ?? [];
    return productList.map((product) => Product.fromJson(jsonDecode(product))).toList();
  }

  List<Product> filterProductsByCategory(List<Product> products, String category) {
    if (category == 'All') {
      return products;
    } else {
      return products.where((product) => product.category == category).toList();
    }
  }
}
