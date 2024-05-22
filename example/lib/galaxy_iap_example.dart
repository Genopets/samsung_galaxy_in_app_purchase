import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_iap/galaxy_iap.dart';
import 'package:galaxy_iap_example/dialogs/consumes_list_dialog.dart';
import 'package:galaxy_iap_example/dialogs/product_detail_dialog.dart';
import 'package:galaxy_iap_example/dialogs/products_list_dialog.dart';
import 'package:galaxy_iap_example/dialogs/purchase_detail_dialog.dart';

class GalaxyIapExample extends StatefulWidget {
  const GalaxyIapExample({super.key});

  @override
  State<GalaxyIapExample> createState() => _GalaxyIapExampleState();
}

class _GalaxyIapExampleState extends State<GalaxyIapExample> {
  final GalaxyIap _galaxyIap = GalaxyIap();
  final itemText = TextEditingController();
  String? lastPurchaseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galaxy IAP Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton('getPlatformVersion'),
            SizedBox(
              width: 150,
              child: TextField(
                controller: itemText,
                decoration: const InputDecoration(helperText: 'Item ID'),
              ),
            ),
            const SizedBox(height: 5),
            _buildButton('getProductDetails'),
            _buildButton('purchaseItem'),
            Text('Last purchaseId: $lastPurchaseId'),
            _buildButton('consumePurchasedItem',
                enabled: lastPurchaseId != null),
            _buildButton('getUserOwnedItems'),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String functionName, {bool enabled = true}) {
    return ElevatedButton(
      onPressed: enabled
          ? () {
              _executeFunction(functionName);
            }
          : null,
      child: Text(functionName),
    );
  }

  Future<void> _executeFunction(String functionName) async {
    dynamic result;
    try {
      switch (functionName) {
        case 'getPlatformVersion':
          String? version = await _galaxyIap.getPlatformVersion();
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(version ?? 'error')),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          break;
        case 'getProductDetails':
          final listResult =
              await _galaxyIap.getProductDetails(itemText.text.trim());
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ProductDetailDialog(item: listResult[0]);
              },
            );
          }

          break;
        case 'purchaseItem':
          final purchase = await _galaxyIap.purchaseItem(
              itemText.text.trim(), 'your_pass_through_param');
          if (mounted && purchase != null) {
            setState(() {
              lastPurchaseId = purchase.mPurchaseId;
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PurchaseDetailDialog(purchase: purchase);
              },
            );
          }
          break;
        case 'consumePurchasedItem':
          if (lastPurchaseId != null) {
            final consumes =
                await _galaxyIap.consumePurchasedItem(lastPurchaseId!);
            if (mounted) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConsumesListDialog(consumes: consumes);
                },
              );
            }
          }
          break;
        case 'getUserOwnedItems':
          final listResult = await _galaxyIap.getUserOwnedItems('item');
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ProductsListDialog(products: listResult);
              },
            );
          }
          break;
        default:
          throw PlatformException(
              code: 'UNSUPPORTED_FUNCTION',
              message: 'Function $functionName not supported');
      }
      debugPrint('Function $functionName executed successfully: $result');
    } on PlatformException catch (e) {
      debugPrint('Error executing function $functionName: ${e.message}');
    }
  }
}
