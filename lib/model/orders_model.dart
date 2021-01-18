class OrdersModel {
  OrdersModel({this.amount, this.orderId, this.name, this.contactNumber, this.emailId, this.orderDate, this.status});

  String amount;
  String orderId;
  String name;
  String contactNumber;
  String emailId;
  String orderDate;
  String status;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount': amount,
        'orderId': orderId,
        'name': name,
        'contactNumber': contactNumber,
        'emailId': emailId,
        'orderDate': orderDate,
        'status': status
      };
  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      amount: map.containsKey('amount') ? (map['amount'] ?? '') : '',
      orderId: map.containsKey('orderId') ? (map['orderId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      contactNumber: map.containsKey('contactNumber') ? (map['contactNumber'] ?? '') : '',
      emailId: map.containsKey('emailId') ? (map['emailId'] ?? '') : '',
      orderDate: map.containsKey('orderDate') ? (map['orderDate'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
    );
  }
}
