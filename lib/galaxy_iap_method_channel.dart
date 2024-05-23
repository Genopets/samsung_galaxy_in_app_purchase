import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_consume.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_owned_product.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_product.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_purchase.dart';
import 'package:samsung_galaxy_in_app_purchase/samsung_galaxy_in_app_purchase.dart';

import 'galaxy_iap_platform_interface.dart';

/// An implementation of [GalaxyIapPlatform] that uses method channels.
class MethodChannelGalaxyIap extends GalaxyIapPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('samsung_galaxy_in_app_purchase');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<GalaxyProduct>> getProductDetails(String productId,
      {OperationMode operationMode = OperationMode.test}) async {
    try {
      final productList =
          await methodChannel.invokeMethod('getPurchasableItems', {
        'productId': productId,
        'operationMode': operationMode.getName(),
      });
      List<dynamic> jsonList = jsonDecode(productList);
      return jsonList
          .map((product) =>
              GalaxyProduct.fromJson(product as Map<String, dynamic>))
          .toList();
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: 'Error while getting product details: ${e.message}',
        details: e.details,
      );
    }
  }

  @override
  Future<GalaxyPurchase?> purchaseItem(
      String productId, String passThroughParam,
      {OperationMode operationMode = OperationMode.test}) async {
    try {
      final purchaseResponse =
          await methodChannel.invokeMethod('purchaseItem', {
        'productId': productId,
        'passThroughParam': passThroughParam,
        'operationMode': operationMode.getName()
      });
      return GalaxyPurchase.fromJson(
          jsonDecode(purchaseResponse) as Map<String, dynamic>);
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: 'Error while purchasing item: ${e.message}',
        details: e.details,
      );
    }
  }

  @override
  Future<List<GalaxyConsume>> consumePurchasedItem(String purchaseId,
      {OperationMode operationMode = OperationMode.test}) async {
    try {
      final consumeList =
          await methodChannel.invokeMethod('consumePurchasedItem', {
        'purchaseId': purchaseId,
        'operationMode': operationMode.getName(),
      });
      List<dynamic> jsonList = jsonDecode(consumeList);
      return jsonList
          .map((product) =>
              GalaxyConsume.fromJson(product as Map<String, dynamic>))
          .toList();
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: 'Error while consuming purchased item: ${e.message}',
        details: e.details,
      );
    }
  }

  @override
  Future<List<GalaxyOwnedProduct>> getUserOwnedItems(String productType,
      {OperationMode operationMode = OperationMode.test}) async {
    try {
      final productList =
          await methodChannel.invokeMethod('getUserOwnedItems', {
        'productType': productType,
        'operationMode': operationMode.getName(),
      });
      List<dynamic> jsonList = jsonDecode(productList);
      return jsonList
          .map((product) =>
              GalaxyOwnedProduct.fromJson(product as Map<String, dynamic>))
          .toList();
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: 'Error while getting user owned items: ${e.message}',
        details: e.details,
      );
    }
  }
}
