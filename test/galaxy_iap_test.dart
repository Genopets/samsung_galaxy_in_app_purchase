import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:galaxy_iap/galaxy_iap_method_channel.dart';

void main() {
  group('MethodChannelGalaxyIap', () {
    late MethodChannelGalaxyIap galaxyIap;

    const MethodChannel channel = MethodChannel('galaxy_iap');

    setUp(() {
      galaxyIap = MethodChannelGalaxyIap();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (methodCall) {
          switch (methodCall.method) {
            case 'getPlatformVersion':
              return Future.value('Mock Android version');
            case 'getPurchasableItems':
              return Future.value(
                  ['Item 1', 'Item 2']); // Mock response for getProductDetails
            case 'purchaseItem':
              return Future.value('Success'); // Mock response for purchaseItem
            case 'consumePurchasedItem':
              return Future.value(
                  'Success'); // Mock response for consumePurchasedItem
            case 'getUserOwnedItems':
              return Future.value([
                'Owned Item 1',
                'Owned Item 2'
              ]); // Mock response for getUserOwnedItems
            default:
              throw PlatformException(
                code: 'Unimplemented',
                message: 'Method ${methodCall.method} not implemented',
              );
          }
        },
      );
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('getPlatformVersion', () async {
      final version = await galaxyIap.getPlatformVersion();
      expect(version, 'Mock Android version');
    });

    test('getProductDetails', () async {
      final productDetails = await galaxyIap.getProductDetails('product_id');
      expect(productDetails, isNotNull);
      expect(productDetails, isA<List>());
      expect(productDetails, containsAll(['Item 1', 'Item 2']));
    });

    test('purchaseItem', () async {
      final result =
          await galaxyIap.purchaseItem('product_id', 'pass_through_param');
      expect(result, 'Success');
    });

    test('consumePurchasedItem', () async {
      final result = await galaxyIap.consumePurchasedItem('purchase_id');
      expect(result, 'Success');
    });

    test('getUserOwnedItems', () async {
      final ownedItems = await galaxyIap.getUserOwnedItems('product_type');
      expect(ownedItems, isNotNull);
      expect(ownedItems, isA<List>());
      expect(ownedItems, containsAll(['Owned Item 1', 'Owned Item 2']));
    });
  });
}
