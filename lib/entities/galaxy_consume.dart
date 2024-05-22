class GalaxyConsume {
  final String mPurchaseId;
  final String mStatusString;
  final int mStatusCode;

  GalaxyConsume({
    required this.mPurchaseId,
    required this.mStatusString,
    required this.mStatusCode,
  });

  factory GalaxyConsume.fromJson(Map<String, dynamic> json) {
    return GalaxyConsume(
      mPurchaseId: json['mPurchaseId'] ?? '',
      mStatusString: json['mStatusString'] ?? '',
      mStatusCode: json['mStatusCode'] ?? 0,
    );
  }
}
