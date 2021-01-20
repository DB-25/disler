class BrandModel {
  String name;
  String fmcgBrandId;
  String status;
  String fmcgDistributorId;

  BrandModel(
      {this.name, this.fmcgBrandId, this.status, this.fmcgDistributorId});

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      fmcgBrandId:
          map.containsKey('fmcgBrandId') ? (map['fmcgBrandId'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
      fmcgDistributorId: map.containsKey('fmcgDistributorId')
          ? (map['fmcgDistributorId'] ?? '')
          : '',
    );
  }
}
