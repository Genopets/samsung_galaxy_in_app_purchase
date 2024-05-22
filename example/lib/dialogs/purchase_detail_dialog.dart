import 'package:flutter/material.dart';
import 'package:galaxy_iap/entities/galaxy_purchase.dart';

class PurchaseDetailDialog extends StatelessWidget {
  final GalaxyPurchase purchase;

  const PurchaseDetailDialog({super.key, required this.purchase});

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
              'Purchase Detail',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('PurchaseId: ${purchase.mPurchaseId}'),
            Text('It is consumable: ${purchase.mConsumableYN}'),
            Text('OrderId: ${purchase.mOrderId}'),
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
