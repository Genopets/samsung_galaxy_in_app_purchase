class GalaxyOwnedProduct {
  String mPaymentId;
  String mPurchaseId;
  String mPurchaseDate;
  String mPassThroughParam;
  String mSubscriptionEndDate;
  bool isConsumable;
  String mItemId;

  GalaxyOwnedProduct({
    required this.mPaymentId,
    required this.mPurchaseId,
    required this.mPurchaseDate,
    required this.mPassThroughParam,
    required this.mSubscriptionEndDate,
    required this.mItemId,
    this.isConsumable = false,
  });

  factory GalaxyOwnedProduct.fromJson(Map<String, dynamic> json) {
    return GalaxyOwnedProduct(
      mPaymentId: json['mPaymentId'] ?? '',
      mPurchaseId: json['mPurchaseId'] ?? '',
      mPurchaseDate: json['mPurchaseDate'] ?? '',
      mPassThroughParam: json['mPassThroughParam'] ?? '',
      mSubscriptionEndDate: json['mSubscriptionEndDate'] ?? '',
      mItemId: json['mItemId'] ?? '',
      isConsumable: json['isConsumable'] ?? false,
    );
  }
}
