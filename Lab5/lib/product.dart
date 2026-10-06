class Product {
  final String title;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final List<String> categories;
  final String description;

  const Product({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.categories,
    required this.description,
  });
}

const sampleProduct = Product(
  title: 'Wireless Over-Ear Headphones',
  imageUrl:
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=1200',
  price: 89.99,
  rating: 4.7,
  reviewCount: 2315,
  categories: ['Electronics', 'Audio', 'Headphones', 'Wireless', 'Bestseller'],
  description:
      'Comfortable over-ear headphones with active noise cancelling, '
      'deep bass and up to 30 hours of battery life.',
);
