class Product {
  final String productName;
  final String storeName;
  final double price;
  final String category;
  final List<String> images;

  Product({
    required this.productName,
    required this.storeName,
    required this.price,
    required this.category,
    required this.images,
  });

  Map<String, dynamic> toJson() => {
        'name': productName,
        'storeName': storeName,
        'price': price,
        'category': category,
        'images': images,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productName: json['name'],
        storeName: json['storeName'],
        price: json['price'],
        category: json['category'],
        images: List<String>.from(json['images']),
      );
}
