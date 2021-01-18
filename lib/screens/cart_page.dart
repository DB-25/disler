import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qirana_app/database/database.dart';
import 'package:qirana_app/model/order_detail_model.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/screens/login_screen.dart';
import 'package:qirana_app/screens/order_confirm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'address_page.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with SingleTickerProviderStateMixin {
  int total = 0;
  List<ProductModel> products = List();
  List<int> quantity = List();
  int itemCount = 0;
  bool isLoading = false;
  double discount = 0.05;
  double superDiscount = 0.10;
  bool enableSuperDiscount = false;
  int delivery = 0;
  int noDelivery = 0;

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    getData();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);

    _controller.addListener(_handleTabSelection);

    super.initState();
  }

  // Widget _buildProgressIndicator() {
  //   return new Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: new Center(
  //       child: new Opacity(
  //         opacity: isLoading ? 1.0 : 00,
  //         child: new CircularProgressIndicator(),
  //       ),
  //     ),
  //   );
  // }

  void getData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      products = await SQLiteDbProvider.db.getCart();
      if (products.isNotEmpty) {
        quantity.clear();
        itemCount = products.length;
        total = 0;
        for (int i = 0; i < itemCount; i++)
          total = total +
              (products[i].retailPrice.toInt() *
                  int.parse(products[i].quantity));
        for (int i = 0; i < itemCount; i++)
          quantity.add(int.parse(products[i].quantity));
      }
      if (products.isEmpty) {
        itemCount = 0;
        total = 0;
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  TabController _controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'My Cart',
                      style: TextStyle(
                          color: Color(0xFFff5860),
                          fontSize: 21,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '$itemCount Products',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TabBar(
                  labelStyle:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  labelColor: Colors.black54,
                  indicatorColor: Color(0xFFff5860),
                  controller: _controller,
                  tabs: [
                    Tab(
                      text: 'Discount',
                    ),
                    Tab(
                      text: 'Super Discount',
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height - 100,
                  child: TabBarView(controller: _controller, children: [
                    products.isEmpty
                        ? Text(
                      'No Items in the Cart',
                      style:
                      TextStyle(fontSize: 21, color: Colors.black54),
                    )
                        : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder:
                                (BuildContext context, int index) =>
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      child: FadeInImage(
                                        height: 100,
                                        width: 55,
                                        placeholder:
                                        AssetImage('assets/logo.png'),
                                        image: NetworkImage(
                                          ApiDriver().getBaseUrl()+'/wp' +
                                              products[index].imageOne,
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                      /*Image.network(
                                          ApiDriver().getBaseUrl()+'/wp' +
                                              products[index].imageOne,
                                          height: 100,
                                          width: 55,
                                          fit: BoxFit.contain,
                                        ),*/
                                    ),
                                    title: Text(
                                      products[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                    subtitle: Text(
                                      products[index].size,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    trailing: Container(
                                      height: 100,
                                      width: 90,
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            (quantity[index] == 0)
                                                ? Text(
                                              'Rs ' +
                                                  products[index]
                                                      .retailPrice
                                                      .round()
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w700,
                                                  fontSize: 16),
                                            )
                                                : Text(
                                              'Rs ' +
                                                  (products[index]
                                                      .retailPrice *
                                                      quantity[
                                                      index])
                                                      .round()
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w700,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: FittedBox(
                                                    child:
                                                    FloatingActionButton(
                                                        elevation: 2,
                                                        backgroundColor:
                                                        Colors.white,
                                                        onPressed: () {
                                                          setState(() {
                                                            if (quantity[
                                                            index] >
                                                                0)
                                                              quantity[
                                                              index]--;
                                                            products[
                                                            index]
                                                                .quantity =
                                                                quantity[
                                                                index]
                                                                    .toString();
                                                            if (quantity[
                                                            index] ==
                                                                0)
                                                              SQLiteDbProvider
                                                                  .db
                                                                  .delete(
                                                                  products[index]
                                                                      .productId);
                                                            else
                                                              SQLiteDbProvider
                                                                  .db
                                                                  .update(
                                                                  products[index],
                                                                  1,
                                                                  0);
                                                            getData();
                                                          });
                                                        },
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                              fontSize:
                                                              30,
                                                              color: Colors
                                                                  .black54),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  quantity[index].toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: FittedBox(
                                                    child:
                                                    FloatingActionButton(
                                                      elevation: 2,
                                                      backgroundColor:
                                                      Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          quantity[index]++;
                                                          products[index]
                                                              .quantity =
                                                              quantity[index]
                                                                  .toString();
                                                          if (quantity[
                                                          index] ==
                                                              1)
                                                            SQLiteDbProvider
                                                                .db
                                                                .insert(
                                                                products[
                                                                index],
                                                                1,
                                                                0);
                                                          else
                                                            SQLiteDbProvider
                                                                .db
                                                                .update(
                                                                products[
                                                                index],
                                                                1,
                                                                0);
                                                          getData();
                                                        });
                                                      },
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors
                                                                .black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            itemCount: itemCount,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Sub Total',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                              Text(
                                'Rs ' +
                                    (total /*- (total * discount)*/.ceil())
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Delivery',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                              Text(
                                'Rs ' + (noDelivery).toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Rs ' +
                                    ((total /*- (total * discount)*/
                                        .ceil()) +
                                        noDelivery)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    products.isEmpty
                        ? Text(
                      'No Items in the Cart',
                      style:
                      TextStyle(fontSize: 22, color: Colors.black54),
                    )
                        : enableSuperDiscount
                        ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder:
                                (BuildContext context, int index) =>
                                Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      child: Image.network(
                                        ApiDriver().getBaseUrl()+'/wp' +
                                            products[index].imageOne,
                                        height: 100,
                                        width: 55,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    title: Text(
                                      products[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                    subtitle: Text(
                                      products[index].size,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    trailing: Container(
                                      height: 100,
                                      width: 90,
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            (quantity[index] == 0)
                                                ? Text(
                                              'Rs ' +
                                                  products[index]
                                                      .retailPrice
                                                      .round()
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .w700,
                                                  fontSize: 16),
                                            )
                                                : Text(
                                              'Rs ' +
                                                  (products[index]
                                                      .retailPrice *
                                                      quantity[
                                                      index])
                                                      .round()
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .w700,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: FittedBox(
                                                    child:
                                                    FloatingActionButton(
                                                        elevation: 2,
                                                        backgroundColor:
                                                        Colors
                                                            .white,
                                                        onPressed:
                                                            () {
                                                          setState(
                                                                  () {
                                                                if (quantity[
                                                                index] >
                                                                    0)
                                                                  quantity[
                                                                  index]--;
                                                                products[
                                                                index]
                                                                    .quantity =
                                                                    quantity[
                                                                    index]
                                                                        .toString();
                                                                if (quantity[
                                                                index] ==
                                                                    0)
                                                                  SQLiteDbProvider
                                                                      .db
                                                                      .delete(
                                                                      products[index]
                                                                          .productId);
                                                                else
                                                                  SQLiteDbProvider
                                                                      .db
                                                                      .update(
                                                                      products[index],
                                                                      1,
                                                                      0);
                                                                getData();
                                                              });
                                                        },
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                              fontSize:
                                                              30,
                                                              color: Colors
                                                                  .black54),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  quantity[index]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: FittedBox(
                                                    child:
                                                    FloatingActionButton(
                                                      elevation: 2,
                                                      backgroundColor:
                                                      Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          quantity[
                                                          index]++;
                                                          products[index]
                                                              .quantity =
                                                              quantity[
                                                              index]
                                                                  .toString();
                                                          if (quantity[
                                                          index] ==
                                                              1)
                                                            SQLiteDbProvider
                                                                .db
                                                                .insert(
                                                                products[
                                                                index],
                                                                1,
                                                                0);
                                                          else
                                                            SQLiteDbProvider
                                                                .db
                                                                .update(
                                                                products[
                                                                index],
                                                                1,
                                                                0);
                                                          getData();
                                                        });
                                                      },
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            color: Colors
                                                                .black54),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            itemCount: itemCount,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Sub Total',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                              Text(
                                'Rs ' +
                                    (total -
                                        (total * superDiscount)
                                            .ceil())
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Delivery',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                              Text(
                                'Rs ' + (delivery).toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Rs ' +
                                    (total -
                                        (total * superDiscount)
                                            .ceil() +
                                        delivery)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                        : Container(
                      height:
                      MediaQuery
                          .of(context)
                          .size
                          .height - 100,
                      child: Center(
                        child: Text(
                          'Coming soon...',
                          style: TextStyle(
                              fontSize: 18, color: Colors.black54),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              _controller.index == 0
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Color(0xFFff5860),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    if (total >= 2000) {
                      order();
                    }
                    else
                      _showDialog();
                  },
                ),
              )
                  : Container(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  order() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('address_added')==null || prefs.getBool('address_added')==false ) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AddressPage(
                products: products,
              ),
        ),
      );
    }
    else
    {
      print(prefs.getString('address_form_data'));
      var formData = json.decode(prefs.getString('address_form_data'));
      OrderDetailModel addressDetails = OrderDetailModel.fromMap(formData);
      ApiResponse response = await apiDriver.orderDetails(
          orderDetailModel: addressDetails,
          productModel: products);
      if (response.data != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderConfirm(
                  orderNo: response.data[0]['cOrderId'],
                  products: products,
                )));
      }
    }
  }

void _showDialog() {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Cart Value Low"),
        content: new Text("Order min of Rs.2000"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      );
    },
  );
}}
