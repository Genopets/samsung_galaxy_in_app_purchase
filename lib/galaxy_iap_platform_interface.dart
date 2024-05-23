import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_consume.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_owned_product.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_product.dart';
import 'package:samsung_galaxy_in_app_purchase/entities/galaxy_purchase.dart';
import 'package:samsung_galaxy_in_app_purchase/samsung_galaxy_in_app_purchase.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'galaxy_iap_method_channel.dart';

abstract class GalaxyIapPlatform extends PlatformInterface {
  /// Constructs a GalaxyIapPlatform.
  GalaxyIapPlatform() : super(token: _token);
  static const Object _token = Object();

  static GalaxyIapPlatform _instance = MethodChannelGalaxyIap();

  /// The default instance of [GalaxyIapPlatform] to use.
  ///
  /// Defaults to [MethodChannelGalaxyIap].
  static GalaxyIapPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GalaxyIapPlatform] when
  /// they register themselves.
  static set instance(GalaxyIapPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<GalaxyProduct>> getProductDetails(String productId,
      {OperationMode operationMode = OperationMode.test}) async {
    throw UnimplementedError('getProductDetails() has not been implemented.');
  }

  Future<GalaxyPurchase?> purchaseItem(
      String productId, String passThroughParam,
      {OperationMode operationMode = OperationMode.test}) async {
    throw UnimplementedError('purchaseItem() has not been implemented.');
  }

  Future<List<GalaxyConsume>> consumePurchasedItem(String purchaseId,
      {OperationMode operationMode = OperationMode.test}) async {
    throw UnimplementedError(
        'consumePurchasedItem() has not been implemented.');
  }

  Future<List<GalaxyOwnedProduct>> getUserOwnedItems(String productType,
      {OperationMode operationMode = OperationMode.test}) async {
    throw UnimplementedError('getUserOwnedItems() has not been implemented.');
  }
}
