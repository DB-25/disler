import 'package:disler/model/orders_model.dart';
import 'package:disler/networking/ApiResponse.dart';
import 'package:disler/networking/api_driver.dart';
import 'package:disler/screens/order_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManualOrder extends StatefulWidget {
  @override
  _ManualOrderState createState() => _ManualOrderState();
}

class _ManualOrderState extends State<ManualOrder> {
  List<OrdersModel> orders = List<OrdersModel>();
  ApiDriver apiDriver = new ApiDriver();

  void getOrders(List data) {
    orders.clear();
    for (var i = 0; i < data.length; i++) {
      orders.add(OrdersModel.fromMap(data[i]));
    }

    orders.sort((a, b) {
      var aDate = a.orderDate;
      var bDate = b.orderDate;
      return bDate.compareTo(aDate);
    });
    for (var i = 0; i < data.length; i++) {
      DateTime date = DateTime.parse(orders[i].orderDate);
      var formatter = new DateFormat('dd-MMM-yyyy');
      orders[i].orderDate = formatter.format(date);
    }
  }

  String userType = '';

  void getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('userType');
  }

  Future<void> getOrdersList() async {
    ApiResponse response = await apiDriver.getOrders();

    getOrders(response.data);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdersList();
    getUserType();
  }

  Widget display(OrdersModel order) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: "Order Id: ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                    TextSpan(
                        text: order.orderId,
                        style: TextStyle(color: Colors.black54, fontSize: 16))
                  ])),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      text: userType == "ROLE_RETAILER"
                          ? "Distributor: "
                          : "Retailer: ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: userType == "ROLE_RETAILER"
                                ? order.name
                                : order.name.toUpperCase(),
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16))
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Date: ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: order.orderDate,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Contact No: ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: order.contactNumber,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16))
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Amount: ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Rs." + order.amount.roundToDouble().toString(),
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                        TextSpan(
                          text: " /-",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Text(
                'Orders',
                style: TextStyle(
                    color: Color(0xFFff5860),
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
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
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetail(
                                  data: orders[index].orderDetail,
                                  address: orders[index].address,
                                ))),
                  },
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.1),
                        height: 1,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: display(orders[index]),
                        // ListTile(
                        //   title: userType == "ROLE_RETAILER"
                        //       ? RichText(
                        //           text: TextSpan(
                        //             text: "Order Id: ",
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 17,
                        //                 color: Colors.black),
                        //             children: <TextSpan>[
                        //               TextSpan(
                        //                 text: orders[index].orderId,
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 13),
                        //               ),
                        //               TextSpan(
                        //                 text: "\nDistributor: " +
                        //                     orders[index].name,
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 17),
                        //               ),
                        //             ],
                        //           ),
                        //           //       "Order Id: " +
                        //           //     orders[index].orderId +
                        //           //     "\nDistributor: " +
                        //           //     orders[index].name,
                        //           // style: TextStyle(
                        //           //     fontWeight: FontWeight.w700,
                        //           //     fontSize: 16),
                        //           maxLines: 4,
                        //           softWrap: true,
                        //         )
                        //       : RichText(
                        //           text: TextSpan(
                        //             text: "Order Id: ",
                        //             style: TextStyle(
                        //                 fontWeight: FontWeight.w600,
                        //                 fontSize: 17,
                        //                 color: Colors.black),
                        //             children: <TextSpan>[
                        //               TextSpan(
                        //                 text: orders[index].orderId,
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 13),
                        //               ),
                        //               TextSpan(
                        //                 text: "\nRetailer: " +
                        //                     orders[index].name.toUpperCase(),
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w600,
                        //                     fontSize: 17),
                        //               ),
                        //             ],
                        //           ),
                        //           //       "Order Id: " +
                        //           //     orders[index].orderId +
                        //           //     "\nDistributor: " +
                        //           //     orders[index].name,
                        //           // style: TextStyle(
                        //           //     fontWeight: FontWeight.w700,
                        //           //     fontSize: 16),
                        //           maxLines: 4,
                        //           softWrap: true,
                        //         ),
                        //   subtitle: Text(
                        //     "Contact No: " +
                        //         orders[index].contactNumber +
                        //         "\nDate: " +
                        //         orders[index].orderDate,
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w700, fontSize: 13),
                        //   ),
                        //   trailing: Container(
                        //     height: 100,
                        //     width: 100,
                        //     child: Center(
                        //       child: Text(
                        //         "Amount: Rs." +
                        //             orders[index]
                        //                 .amount
                        //                 .roundToDouble()
                        //                 .toString() +
                        //             " /-",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w700, fontSize: 16),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
                itemCount: orders.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
