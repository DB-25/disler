class OrderDetailModel {
  String area;
  String city;
  String contactNumber;
  String contestName;
  String country;
  String emailId;
  String houseNo;
  String name;
  String paymentOption;
  String paymentOrderId;
  String state;
  String referralCode;

  OrderDetailModel(
      {this.area,
      this.city,
      this.contactNumber,
      this.contestName,
      this.country,
      this.emailId,
      this.houseNo,
      this.name,
      this.paymentOption,
      this.paymentOrderId,
      this.state,
      this.referralCode});

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      area: map.containsKey('area') ? (map['area'] ?? '') : '',
      city: map.containsKey('city') ? (map['city'] ?? '') : '',
      contactNumber:
          map.containsKey('contactNumber') ? (map['contactNumber'] ?? '') : '',
      contestName:
          map.containsKey('contestName') ? (map['contestName'] ?? '') : '',
      country: map.containsKey('country') ? (map['country'] ?? '') : '',
      emailId: map.containsKey('emailId') ? (map['emailId'] ?? '') : '',
      houseNo: map.containsKey('houseNo') ? (map['houseNo'] ?? '') : '',
      name: map.containsKey('name') ? (map['name'] ?? '') : '',
      paymentOption:
          map.containsKey('paymentOption') ? (map['paymentOption'] ?? '') : '',
      paymentOrderId: map.containsKey('paymentOrderId')
          ? (map['paymentOrderId'] ?? '')
          : '',
      state: map.containsKey('state') ? (map['state'] ?? '') : '',
      referralCode:
          map.containsKey('referralCode') ? (map['referralCode'] ?? '') : '',
    );
  }
}
