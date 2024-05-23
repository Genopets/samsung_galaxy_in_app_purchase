import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxy_iap_example/dialogs/consumes_list_dialog.dart';
import 'package:galaxy_iap_example/dialogs/product_detail_dialog.dart';
import 'package:galaxy_iap_example/dialogs/products_list_dialog.dart';
import 'package:galaxy_iap_example/dialogs/purchase_detail_dialog.dart';
import 'package:samsung_galaxy_in_app_purchase/samsung_galaxy_in_app_purchase.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('getPlatformVersion'),
              _buildTitle('Pseudo step by step process ==', isTitle: true),
              _buildTitle('1st: Enter valid Galaxy Store Item ID'),
              _buildTextfield(),
              _buildTitle('2nd: Fetch its data from the Galaxy Store API'),
              _buildButton('getProductDetails'),
              _buildTitle('3rd: Purchase the item'),
              _buildButton('purchaseItem'),
              _buildTitle('4th: Consume the purchased item'),
              _buildButton('consumePurchasedItem',
                  enabled: lastPurchaseId != null),
              _buildTitle('5th: Get user purchased and consumed items'),
              _buildButton('getUserOwnedItems'),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextfield() {
    return TextField(
      controller: itemText,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15,
        height: 1,
      ),
      decoration: const InputDecoration(
        helperText: '',
        isDense: true,
        contentPadding: EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 10,
          right: 10,
        ),
      ),
    );
  }

  Widget _buildTitle(String title, {bool isTitle = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isTitle ? 10 : 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
              fontSize: isTitle ? 20 : 15),
        ),
      ),
    );
  }

  Widget _buildButton(String functionName, {bool enabled = true}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        onPressed: enabled
            ? () {
                _executeFunction(functionName);
              }
            : null,
        child: Text(functionName),
      ),
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
