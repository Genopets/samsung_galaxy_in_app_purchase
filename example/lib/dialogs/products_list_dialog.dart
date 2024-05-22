import 'package:flutter/material.dart';
import 'package:galaxy_iap/entities/galaxy_owned_product.dart';

class ProductsListDialog extends StatelessWidget {
  final List<GalaxyOwnedProduct> products;

  const ProductsListDialog({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: products
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("PaymentId: ${e.mPaymentId}"),
                              Text("PurchaseDate: ${e.mPurchaseDate}"),
                              Text("PurchaseId: ${e.mPurchaseId}"),
                              const Text("-------------------"),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
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
