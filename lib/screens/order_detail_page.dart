import 'dart:convert';

import 'package:disler/components/icon_btn.dart';
import 'package:disler/model/address_model.dart';
import 'package:disler/model/orders_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetail extends StatefulWidget {
  final String data;
  final AddressModel address;

  OrderDetail({this.data, this.address});

  @override
  _OrderDetailState createState() =>
      _OrderDetailState(data: data, address: address);
}

class _OrderDetailState extends State<OrderDetail> {
  String data;
  AddressModel address;
  List<OrderItemModel> orderItems = List<OrderItemModel>();

  _OrderDetailState({this.data, this.address});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final List t = jsonDecode(data);
    orderItems = t.map((item) => OrderItemModel.fromJson(item)).toList();
    // final add = jsonDecode(address);

    // getAddressDetails(add);
  }

  // AddressModel addressModel;

  // void getAddressDetails(Map<String, dynamic> map) {
  //   addressModel = AddressModel.fromMap(map);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8, top: 10, right: 5),
                  child: IconBtn(
                    icon: Icon(Icons.arrow_back, color: Colors.black45),
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Text(
                    'Address & Order Details',
                    style: TextStyle(
                        color: Color(0xFFff5860),
                        fontSize: 22,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.grey.withOpacity(0.1),
              height: 1,
              margin: EdgeInsets.only(top: 10),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 10.0, top: 15, bottom: 10, left: 15),
                child: Text(
                  'Address: ' +
                      address.houseNo +
                      ',' +
                      address.area +
                      ',' +
                      address.city
                  // ',' +
                  // address.state +
                  // ',' +
                  // address.pincode
                  ,
                  style: GoogleFonts.robotoSlab(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.1),
              height: 1,
              margin: EdgeInsets.only(top: 10),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () => {},
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.1),
                        height: 1,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          title: Text(
                            orderItems[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                            maxLines: 2,
                            softWrap: true,
                          ),
                          subtitle: Text(
                            "Quantity: " +
                                orderItems[index].quantity.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          trailing: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Rs." +
                                    orderItems[index]
                                        .price
                                        .roundToDouble()
                                        .toString() +
                                    " /-",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: orderItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
