class GalaxyPurchase {
  final String mItemId;
  final String mItemName;
  final String mItemDesc;
  final double mItemPrice;
  final String mItemPriceString;
  final String mType;
  final String mConsumableYN;
  final String mCurrencyUnit;
  final String mCurrencyCode;
  final String mItemImageUrl;
  final String mItemDownloadUrl;
  final String mReserved1;
  final String mReserved2;
  final String mOrderId;
  final String mPaymentId;
  final String mPurchaseId;
  final String mPassThroughParam;
  final String mVerifyUrl;
  final String mUdpSignature;
  final String mPurchaseDate;

  GalaxyPurchase({
    required this.mItemId,
    required this.mItemName,
    required this.mItemDesc,
    required this.mItemPrice,
    required this.mItemPriceString,
    required this.mType,
    required this.mConsumableYN,
    required this.mCurrencyUnit,
    required this.mCurrencyCode,
    required this.mItemImageUrl,
    required this.mItemDownloadUrl,
    required this.mReserved1,
    required this.mReserved2,
    required this.mOrderId,
    required this.mPaymentId,
    required this.mPurchaseId,
    required this.mPassThroughParam,
    required this.mVerifyUrl,
    required this.mUdpSignature,
    required this.mPurchaseDate,
  });

  factory GalaxyPurchase.fromJson(Map<String, dynamic> json) {
    return GalaxyPurchase(
      mItemId: json['mItemId'],
      mItemName: json['mItemName'],
      mItemDesc: json['mItemDesc'],
      mItemPrice: json['mItemPrice'].toDouble(),
      mItemPriceString: json['mItemPriceString'],
      mType: json['mType'],
      mConsumableYN: json['mConsumableYN'],
      mCurrencyUnit: json['mCurrencyUnit'],
      mCurrencyCode: json['mCurrencyCode'],
      mItemImageUrl: json['mItemImageUrl'],
      mItemDownloadUrl: json['mItemDownloadUrl'],
      mReserved1: json['mReserved1'],
      mReserved2: json['mReserved2'],
      mOrderId: json['mOrderId'],
      mPaymentId: json['mPaymentId'],
      mPurchaseId: json['mPurchaseId'],
      mPassThroughParam: json['mPassThroughParam'],
      mVerifyUrl: json['mVerifyUrl'],
      mUdpSignature: json['mUdpSignature'],
      mPurchaseDate: json['mPurchaseDate'],
    );
  }
}
