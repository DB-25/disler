class OrderProduct {
  OrderProduct({this.quantity, this.productId, this.size});

  String quantity;
  String productId;
  String size;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'productId': productId,
        'quantity': quantity,
        'size': size,
      };
}
