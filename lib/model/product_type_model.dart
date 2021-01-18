class ProductTypeModel {
  String primaryId;
  String name;
  String description;
  String url;
  String status;

  ProductTypeModel({
    this.primaryId,
    this.name,
    this.description,
    this.url,
    this.status,
  });

  factory ProductTypeModel.fromMap(Map<String, dynamic> map) {
    return ProductTypeModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      description:
          map.containsKey('description') ? (map['description'] ?? '') : '',
      url: map.containsKey('url') ? (map['url'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
