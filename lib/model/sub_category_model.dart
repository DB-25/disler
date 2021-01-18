class SubCategoryModel {
  String subCategoryId;
  String name;
  String description;
  String url;
  String status;

  SubCategoryModel({
    this.subCategoryId,
    this.name,
    this.description,
    this.url,
    this.status,
  });

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      subCategoryId:
          map.containsKey('subCategoryId') ? (map['subCategoryId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      description:
          map.containsKey('description') ? (map['description'] ?? '') : '',
      url: map.containsKey('url') ? (map['url'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
