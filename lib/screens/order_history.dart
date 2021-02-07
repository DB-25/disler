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

class _ManualOrderState extends State<ManualOrder>
    with SingleTickerProviderStateMixin {
  List<OrdersModel> orders = List<OrdersModel>();
  List<OrdersModel> unDeliveredOrders = List<OrdersModel>();
  List<OrdersModel> deliveredOrders = List<OrdersModel>();
  ApiDriver apiDriver = new ApiDriver();

  void getOrders(List data) {
    unDeliveredOrders.clear();
    deliveredOrders.clear();
    orders.clear();
    for (var i = 0; i < data.length; i++) {
      orders.add(OrdersModel.fromMap(data[i]));
    }
    if (userType == "ROLE_RETAILER") {
      orders.sort((a, b) {
        var aDate = a.orderDate;
        var bDate = b.orderDate;
        return bDate.compareTo(aDate);
      });
      for (var i = 0; i < orders.length; i++) {
        DateTime date = DateTime.parse(orders[i].orderDate);
        var formatter = new DateFormat('dd-MMM-yyyy');
        orders[i].orderDate = formatter.format(date);
      }
    } else {
      for (var i = 0; i < orders.length; i++) {
        if (orders[i].status == "Active")
          unDeliveredOrders.add(orders[i]);
        else
          deliveredOrders.add(orders[i]);
      }
      unDeliveredOrders.sort((a, b) {
        var aDate = a.orderDate;
        var bDate = b.orderDate;
        return bDate.compareTo(aDate);
      });
      deliveredOrders.sort((a, b) {
        var aDate = a.orderDate;
        var bDate = b.orderDate;
        return bDate.compareTo(aDate);
      });
      for (var i = 0; i < unDeliveredOrders.length; i++) {
        DateTime date = DateTime.parse(unDeliveredOrders[i].orderDate);
        var formatter = new DateFormat('dd-MMM-yyyy');
        unDeliveredOrders[i].orderDate = formatter.format(date);
      }
      for (var i = 0; i < deliveredOrders.length; i++) {
        DateTime date = DateTime.parse(deliveredOrders[i].orderDate);
        var formatter = new DateFormat('dd-MMM-yyyy');
        deliveredOrders[i].orderDate = formatter.format(date);
      }
    }
  }

  String userType = 'ROLE_RETAILER';

  void getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('userType');
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {});
    });
    Future.delayed(new Duration(seconds: 2), () {
      setState(() {});
    });
    Future.delayed(new Duration(seconds: 3), () {
      setState(() {});
    });
  }

  Future<void> getOrdersList() async {
    ApiResponse response = await apiDriver.getOrders();

    getOrders(response.data);

    setState(() {});
  }

  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, initialIndex: 0, vsync: this);
    _controller.addListener(_handleTabSelection);

    setState(() {
      getOrdersList();
      getUserType();
    });
  }

  void _handleTabSelection() {
    setState(() {});
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
              userType == "ROLE_RETAILER"
                  ? Container()
                  : _controller.index == 0
                      ? RaisedButton(
                          color: Colors.white,
                          elevation: 0,
                          onPressed: () {
                            setState(() async {
                              ApiResponse deliveredResponse = await apiDriver
                                  .changeToDelivered(order.orderId);
                              if (deliveredResponse.status)
                                //TODO:implement this
                                getOrdersList();
                            });
                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFFe24750),
                                  Color(0xFFff5860),
                                  Color(0xFFff8c8d),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Text('Delivered',
                                style: TextStyle(fontSize: 18)),
                          ),
                        )
                      : Container(),
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
        height: MediaQuery.of(context).size.height,
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
            userType == "ROLE_RETAILER"
                ? Container()
                : Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TabBar(
                          labelStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                          labelColor: Colors.black,
                          indicatorColor: Color(0xFFff5860),
                          controller: _controller,
                          unselectedLabelColor: Colors.black54,
                          tabs: [
                            Tab(
                              text: 'UnDelivered',
                            ),
                            Tab(
                              text: 'Delivered',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
            Expanded(
              flex: 10,
              child: Container(
                height: MediaQuery.of(context).size.height - 200,
                child: userType == "ROLE_RETAILER"
                    ? ListView.builder(
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
                      )
                    : TabBarView(controller: _controller, children: [
                        ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetail(
                                            data: unDeliveredOrders[index]
                                                .orderDetail,
                                            address: unDeliveredOrders[index]
                                                .address,
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
                                  child: display(unDeliveredOrders[index]),
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
                          itemCount: unDeliveredOrders.length,
                        ),
                        ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetail(
                                            data: deliveredOrders[index]
                                                .orderDetail,
                                            address:
                                                deliveredOrders[index].address,
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
                                  child: display(deliveredOrders[index]),
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
                          itemCount: deliveredOrders.length,
                        ),
                      ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
