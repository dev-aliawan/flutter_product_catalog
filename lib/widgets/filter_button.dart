import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../utils/constants.dart';

class FilterButton extends ConsumerWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);
    final selectedCategory = productState.selectedCategory;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('التصنيفات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: Constants.categories.map((categoryData) {
              final categoryName = categoryData['name'];
              final categoryImage = categoryData['image'];
              final isSelected = selectedCategory == categoryName;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Card(
                  color: isSelected ? Colors.blue[100] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: isSelected ? const BorderSide(color: Colors.blue, width: 1.0) : BorderSide.none,
                  ),
                  child: InkWell(
                    onTap: () {
                      final notifier = ref.read(productProvider.notifier);
                      notifier.filterProductsByCategory(categoryName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                            categoryImage!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            categoryName!,
                            style: TextStyle(
                              color: isSelected ? Colors.blue : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
