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
          children: [buildCover()],
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
}
