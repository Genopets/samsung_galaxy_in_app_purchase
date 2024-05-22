class GalaxyProduct {
  final String itemId;
  final String itemName;
  final double itemPrice;
  final String itemPriceString;
  final String currencyUnit;
  final String currencyCode;
  final String itemDesc;
  final String itemImageUrl;
  final String itemDownloadUrl;
  final String reserved1;
  final String reserved2;
  final String type;
  final String consumableYN;
  final String freeTrialPeriod;
  final String subscriptionDurationUnit;
  final String subscriptionDurationMultiplier;
  final String tieredSubscriptionYN;
  final String tieredPrice;
  final String tieredPriceString;
  final String tieredSubscriptionCount;
  final String tieredSubscriptionDurationMultiplier;
  final String tieredSubscriptionDurationUnit;
  final int showStartDate;
  final int showEndDate;

  GalaxyProduct({
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.itemPriceString,
    required this.currencyUnit,
    required this.currencyCode,
    required this.itemDesc,
    required this.itemImageUrl,
    required this.itemDownloadUrl,
    required this.reserved1,
    required this.reserved2,
    required this.type,
    required this.consumableYN,
    required this.freeTrialPeriod,
    required this.subscriptionDurationUnit,
    required this.subscriptionDurationMultiplier,
    required this.tieredSubscriptionYN,
    required this.tieredPrice,
    required this.tieredPriceString,
    required this.tieredSubscriptionCount,
    required this.tieredSubscriptionDurationMultiplier,
    required this.tieredSubscriptionDurationUnit,
    required this.showStartDate,
    required this.showEndDate,
  });

  factory GalaxyProduct.fromJson(Map<String, dynamic> json) {
    return GalaxyProduct(
      itemId: json['mItemId'],
      itemName: json['mItemName'],
      itemPrice: json['mItemPrice'].toDouble(),
      itemPriceString: json['mItemPriceString'],
      currencyUnit: json['mCurrencyUnit'],
      currencyCode: json['mCurrencyCode'],
      itemDesc: json['mItemDesc'],
      itemImageUrl: json['mItemImageUrl'],
      itemDownloadUrl: json['mItemDownloadUrl'],
      reserved1: json['mReserved1'],
      reserved2: json['mReserved2'],
      type: json['mType'],
      consumableYN: json['mConsumableYN'],
      freeTrialPeriod: json['mFreeTrialPeriod'],
      subscriptionDurationUnit: json['mSubscriptionDurationUnit'],
      subscriptionDurationMultiplier: json['mSubscriptionDurationMultiplier'],
      tieredSubscriptionYN: json['mTieredSubscriptionYN'],
      tieredPrice: json['mTieredPrice'],
      tieredPriceString: json['mTieredPriceString'],
      tieredSubscriptionCount: json['mTieredSubscriptionCount'],
      tieredSubscriptionDurationMultiplier:
          json['mTieredSubscriptionDurationMultiplier'],
      tieredSubscriptionDurationUnit: json['mTieredSubscriptionDurationUnit'],
      showStartDate: json['mShowStartDate'],
      showEndDate: json['mShowEndDate'],
    );
  }
}
