import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductState {
  final List<Product> products;
  final List<Product> allProducts;
  final String selectedCategory;

  ProductState({required this.products, required this.allProducts, required this.selectedCategory});

  ProductState copyWith({List<Product>? products, List<Product>? allProducts, String? selectedCategory}) {
    return ProductState(
      products: products ?? this.products,
      allProducts: allProducts ?? this.allProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductService _service;

  ProductNotifier(this._service) : super(ProductState(products: [], allProducts: [], selectedCategory: 'عرض الكل')) {
    loadProducts();
  }

  void addProduct(Product product) {
    final updatedProducts = [product, ...state.allProducts];
    state = state.copyWith(allProducts: updatedProducts);
    _service.saveProducts(updatedProducts);
    filterProductsByCategory(state.selectedCategory);
  }

  void removeProduct(Product product) {
    final updatedProducts = state.allProducts.where((p) => p != product).toList();
    state = state.copyWith(allProducts: updatedProducts);
    _service.saveProducts(updatedProducts);
    filterProductsByCategory(state.selectedCategory);
  }

  void loadProducts() async {
    final products = await _service.loadProducts();
    state = state.copyWith(allProducts: products, products: products);
  }

  void filterProductsByCategory(String category) {
    List<Product> filteredProducts;
    if (category == 'عرض الكل') {
      filteredProducts = state.allProducts;
    } else {
      filteredProducts = state.allProducts.where((product) => product.category == category).toList();
    }
    state = state.copyWith(products: filteredProducts, selectedCategory: category);
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(ProductService());
});
