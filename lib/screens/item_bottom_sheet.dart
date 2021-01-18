import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qirana_app/components/icon_btn.dart';
import 'package:qirana_app/database/database.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/api_driver.dart';

class ItemBottomSheet extends StatefulWidget {
  ItemBottomSheet({this.product});

  final ProductModel product;

  @override
  _ItemBottomSheetState createState() =>
      _ItemBottomSheetState(productModel: product);
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  _ItemBottomSheetState({this.productModel});

  ProductModel productModel;
  int quantity;
  FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    quantity = int.parse(productModel.quantity);
    super.initState();
  }

  _showToast(String msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black54,
      ),
      child: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white38,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 50),
                      child: Carousel(
                        images: [
                          Hero(
                              tag: 'image',
                              child: Image(
                                  image: NetworkImage(
                                      ApiDriver().getBaseUrl()+'/wp' +
                                          productModel.imageOne))),
                          NetworkImage(ApiDriver().getBaseUrl()+'/wp' +
                              productModel.imageOne),
                        ],
                        boxFit: BoxFit.contain,
                        showIndicator: true,
                        dotIncreaseSize: 1.5,
                        dotBgColor: Colors.black.withOpacity(0),
                        dotColor: Colors.white.withOpacity(0.4),
                        borderRadius: false,
                        moveIndicatorFromBottom: 180.0,
                        noRadiusForIndicator: true,
                        overlayShadow: false,
                        overlayShadowColors: Colors.white,
                        overlayShadowSize: 0.7,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2 - 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Text(
                                productModel.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 21),
                                maxLines: 2,
                                softWrap: true,
                              ),
                            ),

                            Container(
                              child: Text(
                                productModel.size,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                                softWrap: true,
                              ),
                            ),
//                          SizedBox(
//                            height: 30,
//                          ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   width: 40,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: (quantity == 0)
                                      ? Text(
                                          'Product MRP: ₹ ' +
                                              productModel.mrp
                                                  .round()
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        )
                                      : Text(
                                          'Product MRP: ₹ ' +
                                              (productModel.mrp * quantity)
                                                  .round()
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: (quantity == 0)
                                      ? Text(
                                          'Selling Price: ₹ ' +
                                              productModel.retailPrice
                                                  .round()
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFff5860),
                                              fontSize: 20),
                                        )
                                      : Text(
                                          'Selling Price: ₹ ' +
                                              (productModel.retailPrice *
                                                      quantity)
                                                  .round()
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFff5860),
                                              fontSize: 21),
                                        ),
                                ),
                              ],
                            ),
//                          SizedBox(
//                            height: 30,
//                          ),
                            Container(
                              child: Text(
                                productModel.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                                maxLines: 3,
                                softWrap: true,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 50,
                                  child: FloatingActionButton(
                                      elevation: 0.5,
                                      backgroundColor: Color(0xfff6f6f6),
                                      onPressed: () {
                                        setState(() {
                                          if (quantity > 0) quantity--;
                                          productModel.quantity =
                                              quantity.toString();
                                        });
                                      },
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.black),
                                      )),
                                ),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: FloatingActionButton(
                                    elevation: 0.5,
                                    backgroundColor: Color(0xfff6f6f6),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                        productModel.quantity =
                                            quantity.toString();
                                      });
                                    },
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                              ],
                            ),
//                          SizedBox(
//                            height: 50,
//                          ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                color: Color(0xFFff5860),
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      "Add to cart",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: () {
                                  if (quantity != 0)
                                    SQLiteDbProvider.db
                                        .insert(productModel, 1, 0);
                                  if (quantity != 0)
                                    _showToast('Item added to Cart');
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: IconBtn(
                  icon: Icon(Icons.arrow_back, color: Colors.black54),
                  press: () {
                    Navigator.pop(context);
                  }),
            ),
            /*IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),*/
          ],
        ),
      ),
    );
  }
}
