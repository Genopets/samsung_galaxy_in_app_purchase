import 'package:flutter/material.dart';
import 'package:galaxy_iap/entities/galaxy_product.dart';

class ProductDetailDialog extends StatelessWidget {
  final GalaxyProduct item;

  const ProductDetailDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Item Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('ID: ${item.itemId}'),
            Text('Name: ${item.itemName}'),
            Text('Price: ${item.itemPriceString}'),
            Text('Description: ${item.itemDesc}'),
            Text('Type: ${item.type}'),
            // Add more details as needed
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
