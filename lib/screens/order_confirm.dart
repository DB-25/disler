import 'package:flutter/material.dart';
import 'package:qirana_app/model/product_model.dart';

class OrderConfirm extends StatelessWidget {
  OrderConfirm({this.orderNo, this.products});
  final String orderNo;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (int i = 0; i < products.length; i++)
      total += products[i].price.round() * int.parse(products[i].quantity);
    double leftPadding = MediaQuery.of(context).size.width - 45;
    return Scaffold(
      backgroundColor: Color(0xff183B8C),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: leftPadding, right: 5.0),
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xffFECBCA),
                child: Icon(
                  Icons.done,
                  size: 80,
                  color: Color(0xff183B8C),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'YOUR ORDER HAS BEEN CONFIRMED',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xffFECBCA),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Order number $orderNo',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == products.length)
                          return ListTile(
                            leading: Text(
                              "Total",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              "Rs $total",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        else
                          return ListTile(
                            leading: Text(
                              products[index].name,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text(
                              products[index].price.round().toString() +
                                  ' x ' +
                                  products[index].quantity +
                                  ' = ' +
                                  (products[index].price.round() *
                                          int.parse(products[index].quantity))
                                      .toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                      },
                      itemCount: products.length + 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Color(0xffFECBCA),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "SHOP MORE",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
