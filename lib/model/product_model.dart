class ProductModel {
  String productId;
  String name;
  String metaDescription;
  String description;
  String url;
  double discount;
  String imageOne;
  String imageTwo;
  double price;
  double retailPrice;
  double wholesalePrice;
  double mrp;
  String status;
  String size;
  String quantity;

  static final columns = [
    "productId",
    "name",
    "metaDescription",
    "price",
    "retailPrice",
    "mrp",
    "imageOne",
    "size",
    "quantity",
    "cart",
    "fav"
  ];

  ProductModel(
      {this.productId,
      this.name,
      this.metaDescription,
      this.description,
      this.url,
      this.discount,
      this.retailPrice,
      this.wholesalePrice,
      this.mrp,
      this.imageOne,
      this.imageTwo,
      this.price,
      this.status,
      this.size,
      this.quantity});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map.containsKey('productId') ? (map['productId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      metaDescription: map.containsKey('metaDescription')
          ? (map['metaDescription'] ?? '')
          : '',
      description:
          map.containsKey('description') ? (map['description'] ?? '') : '',
      url: map.containsKey('url') ? (map['url'] ?? '') : '',
      discount: map.containsKey('discount') ? (map['discount'] ?? '') : 0.0,
      retailPrice: map.containsKey('retailPrice')
          ? (map['retailPrice'] + 0.0 ?? '')
          : 0.0,
      wholesalePrice: map.containsKey('wholesalePrice')
          ? (map['wholesalePrice'] + 0.0 ?? '')
          : 0.0,
      mrp: map.containsKey('mrp') ? (map['mrp'] + 0.0 ?? '') : 0.0,
      imageOne: map.containsKey('imageOne') ? (map['imageOne'] ?? '') : '',
      imageTwo: map.containsKey('imageTwo') ? (map['imageTwo'] ?? '') : '',
      price: map.containsKey('price') ? (map['price'] + 0.0 ?? '') : 0.0,
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
      size: map.containsKey('size') ? (map['size'] ?? '') : '',
      quantity: map.containsKey('quantity') ? (map['quantity'] ?? '') : '0',
    );
  }

  Map<String, dynamic> toMap(int cart, int fav) => {
        "productId": productId,
        "name": name,
        "metaDescription": metaDescription,
        "price": price,
        "retailPrice": retailPrice,
        "mrp": mrp,
        "imageOne": imageOne,
        "size": size,
        "quantity": quantity,
        "cart": cart,
        "fav": fav
      };
}
