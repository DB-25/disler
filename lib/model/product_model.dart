class ProductModel {
  String productId;
  String name;
  String metaDescription;
  String description;
  String imageOne;
  String imageTwo;
  double price;
  double mrp;
  String status;
  int quantity;
  String item;
  String weight;
  String ecomInventoryId;
  double minQty;
  String url;
  String sellingQuantity;

  static final columns = [
    "name",
    "metaDescription",
    "price",
    "mrp",
    "productId",
    "imageOne",
    "weight",
    "ecomInventoryId",
    "quantity",
    "minQty",
    "cart",
    "fav"
  ];

  ProductModel(
      {this.productId,
      this.name,
      this.metaDescription,
      this.description,
      this.url,
      this.minQty,
      this.ecomInventoryId,
      this.weight,
      this.mrp,
      this.imageOne,
      this.imageTwo,
      this.price,
      this.status,
      this.item,
      this.quantity,
      this.sellingQuantity});

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
      ecomInventoryId: map.containsKey('ecomInventoryId')
          ? (map['ecomInventoryId'] ?? '')
          : '',
      minQty: map.containsKey('minQty') ? (map['minQty'] + 0.0 ?? '') : 0.0,
      item: map.containsKey('item') ? (map['item'] ?? '') : '',
      mrp: map.containsKey('mrp') ? (map['mrp'] + 0.0 ?? '') : 0.0,
      imageOne: map.containsKey('imageOne') ? (map['imageOne'] ?? '') : '',
      imageTwo: map.containsKey('imageTwo') ? (map['imageTwo'] ?? '') : '',
      price: map.containsKey('price') ? (map['price'] + 0.0 ?? '') : 0.0,
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
      weight: map.containsKey('weight') ? (map['weight'] ?? '') : '',
      sellingQuantity:
          map.containsKey('quantity') ? (map['quantity'] ?? '') : '',
      quantity: 0,
    );
  }

  factory ProductModel.fromMap2(Map<String, dynamic> map) {
    return ProductModel(
      productId: map.containsKey('productId') ? (map['productId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      metaDescription: map.containsKey('metaDescription')
          ? (map['metaDescription'] ?? '')
          : '',
      description:
          map.containsKey('description') ? (map['description'] ?? '') : '',
      url: map.containsKey('url') ? (map['url'] ?? '') : '',
      ecomInventoryId: map.containsKey('ecomInventoryId')
          ? (map['ecomInventoryId'] ?? '')
          : '',
      minQty: map.containsKey('minQty') ? (map['minQty'] + 0.0 ?? '') : 0.0,
      item: map.containsKey('item') ? (map['item'] ?? '') : '',
      mrp: map.containsKey('mrp') ? (map['mrp'] + 0.0 ?? '') : 0.0,
      imageOne: map.containsKey('imageOne') ? (map['imageOne'] ?? '') : '',
      imageTwo: map.containsKey('imageTwo') ? (map['imageTwo'] ?? '') : '',
      price: map.containsKey('price') ? (map['price'] + 0.0 ?? '') : 0.0,
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
      weight: map.containsKey('weight') ? (map['weight'] ?? '') : '',
      quantity: map.containsKey('quantity') ? (map['quantity'] ?? '') : '',
    );
  }
  Map<String, dynamic> toMap(int cart, int fav) => {
        "ecomInventoryId": ecomInventoryId,
        "name": name,
        "metaDescription": metaDescription,
        "price": price,
        "mrp": mrp,
        "productId": productId,
        "imageOne": imageOne,
        "weight": weight,
        "quantity": quantity,
        "minQty": minQty,
        "cart": cart,
        "fav": fav
      };
}
