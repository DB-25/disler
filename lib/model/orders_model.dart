import 'dart:convert';

import 'package:disler/model/address_model.dart';

class OrdersModel {
  OrdersModel(
      {this.amount,
      this.orderId,
      this.name,
      this.contactNumber,
      this.emailId,
      this.orderDate,
      this.status,
      this.orderDetail,
      this.address});

  double amount;
  String orderId;
  String name;
  String contactNumber;
  String emailId;
  String orderDate;
  String status;
  String orderDetail;
  AddressModel address;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'amount': amount,
        'orderId': orderId,
        'name': name,
        'contactNumber': contactNumber,
        'emailId': emailId,
        'orderDate': orderDate,
        'status': status,
        'orderDetail': orderDetail,
        'address': address
      };
  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      amount: map.containsKey('amount') ? (map['amount'] + 0.0 ?? '') : 0.0,
      orderId: map.containsKey('orderId') ? (map['orderId'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      address: map.containsKey('address')
          ? (AddressModel.fromMap(map['address']) ?? '')
          : '',
      contactNumber:
          map.containsKey('contactNumber') ? (map['contactNumber'] ?? '') : '',
      emailId: map.containsKey('emailId') ? (map['emailId'] ?? '') : '',
      orderDate: map.containsKey('orderDate') ? (map['orderDate'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
      orderDetail: map.containsKey('orderDetail')
          ? (jsonEncode(map['orderDetail']).toString() ?? '')
          : '',
    );
  }
}
