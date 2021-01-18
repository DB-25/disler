class BannerModel {
  String primaryId;
  String bannerOne;
  String bannerTwo;
  String bannerThree;
  String status;

  BannerModel({
    this.primaryId,
    this.bannerOne,
    this.bannerTwo,
    this.bannerThree,
    this.status,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      bannerOne: map.containsKey('bannerOne') ? (map['bannerOne'] ?? '') : '',
      bannerTwo: map.containsKey('bannerTwo') ? (map['bannerTwo'] ?? '') : '',
      bannerThree:
          map.containsKey('bannerThree') ? (map['bannerThree'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
