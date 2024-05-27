import 'dart:io';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String storeName;
  final double price;
  final List<String> images;
  final VoidCallback onDelete;
  final bool isGridView;

  const ProductCard({
    super.key,
    required this.productName,
    required this.storeName,
    required this.price,
    required this.images,
    required this.onDelete,
    this.isGridView = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(productName),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('$productName تم حذف المنتج بنجاح')),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 3),
          ),
        );
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("يتأكد"),
              content: const Text("هل أنت متأكد أنك تريد حذف هذا المنتج؟"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("إلغاء"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("حذف"),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: isGridView ? _buildGridViewLayout() : _buildListViewLayout(),
      ),
    );
  }

  Widget _buildListViewLayout() {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: _buildImage(),
      ),
      title: Text(
        productName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$price ',
                  style: const TextStyle(color: Color(0xFF3EB86F), fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: 'دولار',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: const Color(0xFFEEEEEE),
            ),
            child: Text(
              storeName,
              style: const TextStyle(color: Color(0xFFA1A1A1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridViewLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: _buildImage(),
            ),
            const SizedBox(height: 8),
            Text(
              productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '$price ',
                  style: const TextStyle(
                    color: Color(0xFF3EB86F),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'دولار',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              storeName,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (images.isNotEmpty) {
      final imagePath = images.first;
      if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
        return Image.file(
          File(imagePath),
          width: isGridView ? double.infinity : 80,
          height: isGridView ? 100 : 80,
          fit: BoxFit.cover,
        );
      }
    }
    // Return a placeholder icon if there's no image
    return Container(
      width: isGridView ? double.infinity : 80,
      height: isGridView ? 100 : 80,
      color: Colors.grey[200],
      child: Icon(
        Icons.image_not_supported,
        size: 40,
        color: Colors.grey[600],
      ),
    );
  }
}
