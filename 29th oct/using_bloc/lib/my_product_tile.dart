import 'package:flutter/material.dart';
import 'package:using_bloc/model.dart';

class MyProductTile extends StatelessWidget {
  final ProductsModel product;
  const MyProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(product.thumbnail),
          ),
        title: Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description),
            Text(product.price)
          ],
        ));
  }
}
