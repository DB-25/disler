class OrderProduct {
  OrderProduct(
      {this.quantity, this.ecomInventoryId, this.weight, this.productId});

  String productId;
  String quantity;
  String ecomInventoryId;
  String weight;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ecomInventoryId': ecomInventoryId,
        'quantity': quantity,
        'size': weight,
        'productId': productId
      };
}
