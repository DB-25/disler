class AddressModel {
  String area;
  String country;
  String pincode;
  String city;
  String houseNo;
  String state;
  String addressId;
  String status;

  AddressModel(
      {this.area,
      this.status,
      this.addressId,
      this.city,
      this.country,
      this.houseNo,
      this.pincode,
      this.state});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'area': area,
        'status': status,
        'addressId': addressId,
        'city': city,
        'country': country,
        'houseNo': houseNo,
        'pincode': pincode,
        'state': state
      };

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressId: map.containsKey('addressId') ? (map['addressId'] ?? '') : '',
      area: map.containsKey('area') ? (map['area'] ?? '') : '',
      state: map.containsKey('state') ? (map['state'] ?? '') : '',
      status: map.containsKey('status') ? (map['status'] ?? '') : '',
      city: map.containsKey('city') ? (map['city'] ?? '') : '',
      houseNo: map.containsKey('houseNo') ? (map['houseNo'] ?? '') : '',
      pincode: map.containsKey('pincode') ? (map['pincode'] ?? '') : '',
      country: map.containsKey('country') ? (map['country'] ?? '') : '',
    );
  }
}
