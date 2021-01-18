class CategoryModel {
  String categoryId;
  String name;
  String description;
  String imageOne;
  String url;
//  int position;
  String status;

  CategoryModel({
    this.categoryId,
    this.name,
    this.description,
    this.imageOne,
    this.url,
//    this.position,
    this.status,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map.containsKey('categoryId')
          ? (map['categoryId'] ?? '')
          : (map.containsKey('subCategoryId')
              ? (map['subCategoryId'] ?? '')
              : ''),
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      description:
          map.containsKey('description') ? (map['description'] ?? '') : '',
      imageOne: map.containsKey('imageOne') ? (map['imageOne'] ?? '') : '',
      url: map.containsKey('url') ? (map['url'] ?? '') : '',
//      position: map.containsKey('position') ? (map['position'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
