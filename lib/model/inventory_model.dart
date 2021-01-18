class InventoryModel {
  String primaryId;
  String buyingDate;
  String item;
  int quantity;
  String weight;
  double price;
  double mrp;
  String buyerName;
  String unitPrice;

  InventoryModel(
      {this.primaryId,
      this.buyingDate,
      this.item,
      this.quantity,
      this.weight,
      this.price,
      this.mrp,
      this.buyerName,
      this.unitPrice});

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(
      primaryId: map.containsKey('primaryId') ? (map['primaryId'] ?? '') : '',
      buyingDate:
          map.containsKey('buyingDate') ? (map['buyingDate'] ?? '') : '',
      item: map.containsKey('item') ? (map['item'] ?? '') : '',
      quantity: map.containsKey('quantity') ? (map['quantity'] ?? '') : '',
      weight: map.containsKey('weight') ? (map['weight'] ?? '') : '',
      price: map.containsKey('price') ? (map['price'] ?? '') : '',
      mrp: map.containsKey('mrp') ? (map['mrp'] ?? '') : '',
      buyerName: map.containsKey('buyerName') ? (map['buyerName'] ?? '') : '',
      unitPrice: map.containsKey('unitPrice') ? (map['unitPrice'] ?? '') : '',
    );
  }
}
