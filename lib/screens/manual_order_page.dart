import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qirana_app/model/orders_model.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/networking/api_driver.dart';

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
  }

  Future<List<OrdersModel>> getOrdersList() async {
    ApiResponse response = await apiDriver.getOrders();
    getOrders(response.data);
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdersList();
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
                itemBuilder: (BuildContext context, int index) => Column(
                  children: [
                    Container(
                      color: Colors.grey.withOpacity(0.1),
                      height: 1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        title: Text(
                          "Order Id: "+orders[index].orderId,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                          maxLines: 2,
                          softWrap: true,
                        ),
                        subtitle: Text(
                          "Date: "+orders[index].orderDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                        trailing: Container(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Text(
                              "Rs."+orders[index].orderId+"/-",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                itemCount:orders.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
