import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'add_product_page.dart';
import '../widgets/filter_button.dart';

final orientationProvider = StateProvider<bool>((ref) => true); // true for ListView, false for GridView

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider).products;
    final isHorizontal = ref.watch(orientationProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('المنتجات'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage()));
              },
              icon: const Icon(
                Icons.add,
                size: 28,
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FilterButton(),
            TextButton.icon(
              onPressed: () {
                ref.read(orientationProvider.notifier).state = !isHorizontal;
              },
              icon: Icon(isHorizontal ? Icons.view_list : Icons.view_module),
              label: Text(
                isHorizontal ? 'تغيير عرض المنتجات إلى الوضع العمودي' : 'تغيير عرض المنتجات إلى الوضع الأفقي',
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.white,
              ),
            ),
            Expanded(
              child: products.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, size: 100, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          const Text(
                            'لا توجد منتجات متاحة',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'أضف منتجات جديدة باستخدام الزر أدناه',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductPage()));
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('إضافة منتج'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    )
                  : isHorizontal
                      ? ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              productName: product.productName,
                              storeName: product.storeName,
                              price: product.price,
                              images: product.images,
                              onDelete: () {
                                ref.read(productProvider.notifier).removeProduct(product);
                              },
                              isGridView: false,
                            );
                          },
                        )
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              productName: product.productName,
                              storeName: product.storeName,
                              price: product.price,
                              images: product.images,
                              onDelete: () {
                                ref.read(productProvider.notifier).removeProduct(product);
                              },
                              isGridView: true,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
