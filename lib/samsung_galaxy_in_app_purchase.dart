import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_consume.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_owned_product.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_product.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_purchase.dart';

import 'galaxy_iap_platform_interface.dart';

class GalaxyIap {
  final GalaxyIapPlatform _platform = GalaxyIapPlatform.instance;

  Future<String?> getPlatformVersion() async {
    return await _platform.getPlatformVersion();
  }

  Future<List<GalaxyProduct>> getProductDetails(String productId,
      {OperationMode operationMode = OperationMode.test}) async {
    return await _platform.getProductDetails(
      productId,
      operationMode: operationMode,
    );
  }

  Future<GalaxyPurchase?> purchaseItem(
      String productId, String passThroughParam,
      {OperationMode operationMode = OperationMode.test}) async {
    return await _platform.purchaseItem(
      productId,
      passThroughParam,
      operationMode: operationMode,
    );
  }

  Future<List<GalaxyConsume>> consumePurchasedItem(String purchaseId,
      {OperationMode operationMode = OperationMode.test}) async {
    return await _platform.consumePurchasedItem(
      purchaseId,
      operationMode: operationMode,
    );
  }

  Future<List<GalaxyOwnedProduct>> getUserOwnedItems(String productType,
      {OperationMode operationMode = OperationMode.test}) async {
    return await _platform.getUserOwnedItems(
      productType,
      operationMode: operationMode,
    );
  }
}

enum OperationMode {
  production,
  test,
  testFailure,
}

extension StringParse on OperationMode {
  String getName() {
    switch (this) {
      case OperationMode.production:
        return 'OPERATION_MODE_PRODUCTION';
      case OperationMode.test:
        return 'OPERATION_MODE_TEST';
      case OperationMode.testFailure:
        return 'OPERATION_MODE_TEST_FAILURE';
    }
  }
}
