import 'package:flutter/material.dart';
import 'package:galaxy_iap/entities/galaxy_consume.dart';

class ConsumesListDialog extends StatelessWidget {
  final List<GalaxyConsume> consumes;

  const ConsumesListDialog({super.key, required this.consumes});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: consumes
                        .map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("PaymentId: ${e.mPurchaseId}"),
                                Text("StatusCode: ${e.mStatusCode}"),
                                Text("StatusString: ${e.mStatusString}"),
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
      ),
    );
  }
}
