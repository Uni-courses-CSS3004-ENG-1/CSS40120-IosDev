import 'package:flutter/material.dart';

import 'product.dart';
import 'product_detail_screen.dart';

void main() {
  runApp(const ProductPreviewApp());
}

class ProductPreviewApp extends StatelessWidget {
  const ProductPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Preview',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ProductDetailScreen(product: sampleProduct),
    );
  }
}
