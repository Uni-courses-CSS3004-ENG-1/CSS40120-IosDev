import 'package:flutter/material.dart';

import 'product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isBookmarked = false;

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Preview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [buildCover(), const SizedBox(height: 16), buildInfo()],
        ),
      ),
    );
  }

  // Stack: image at the bottom, bookmark badge on top of it
  Widget buildCover() {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
                // Shown when there is no internet
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image, size: 64),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: toggleBookmark,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfo() {
    final product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row: title on the left, price on the right
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded lets a long title go to the next line
            Expanded(
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Row: star icon + rating
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber),
            const SizedBox(width: 4),
            Expanded(
              child: Text('${product.rating} (${product.reviewCount} reviews)'),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Wrap: badges move to the next line when there is no space
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final category in product.categories)
              Chip(label: Text(category)),
          ],
        ),
        const SizedBox(height: 16),

        const Text(
          'Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(product.description),
      ],
    );
  }
}
