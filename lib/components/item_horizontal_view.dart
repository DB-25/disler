import 'package:disler/database/database.dart';
import 'package:disler/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class ItemHorizontalView extends StatefulWidget {
  ItemHorizontalView({this.product});

  ProductModel product;
  @override
  _ItemHorizontalViewState createState() =>
      _ItemHorizontalViewState(productModel: product);
}

class _ItemHorizontalViewState extends State<ItemHorizontalView> {
  _ItemHorizontalViewState({this.productModel});
  ProductModel productModel;
  int quantity = 0;
  FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    if (productModel != null) quantity = productModel.minQty.round();
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
      toastDuration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://api.fagnum.com/wp' + productModel.imageOne,
            height: 100,
            width: 55,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          productModel.name,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          maxLines: 2,
          softWrap: true,
        ),
        subtitle: Text(
          productModel.weight + "\nQty:" + productModel.sellingQuantity,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        trailing: Container(
          height: 100,
          width: 90,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // (quantity == 0)
                //     ?
                Text(
                  'Rs ' + productModel.price.roundToDouble().toString(),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                // :
                // Text(
                //         'Rs ' +
                //             (productModel.price * quantity)
                //                 .roundToDouble()
                //                 .toString(),
                //         style: TextStyle(
                //             fontWeight: FontWeight.w700, fontSize: 17),
                //       ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 25,
                      width: 25,
                      child: FittedBox(
                        child: FloatingActionButton(
                            elevation: 5,
                            backgroundColor: Colors.white,
                            onPressed: () async {
                              bool hasItemInCart = await SQLiteDbProvider.db
                                  .checkItem(productModel.ecomInventoryId);
                              setState(
                                () {
                                  //normal deletion
                                  if (quantity > productModel.minQty.round()) {
                                    quantity--;
                                    productModel.quantity = quantity;
                                    SQLiteDbProvider.db
                                        .update(productModel, 1, 0);
                                    _showToast('Item updated in Cart');
                                  }
                                  //full deletion
                                  else if (quantity ==
                                      productModel.minQty.round()) {
                                    if (hasItemInCart) {
                                      SQLiteDbProvider.db
                                          .delete(productModel.ecomInventoryId);
                                      _showToast('Item Deleted from Cart');
                                    } else {
                                      _showToast('Order min Qty is ' +
                                          productModel.minQty
                                              .round()
                                              .toString());
                                    }
                                    quantity = productModel.minQty.round();
                                  }
                                },
                              );
                            },
                            child: Text(
                              '-',
                              style: TextStyle(
                                  fontSize: 30, color: Color(0xFFff5860)),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      quantity.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      child: FittedBox(
                        child: FloatingActionButton(
                          elevation: 5,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            bool hasItemInCart = await SQLiteDbProvider.db
                                .checkItem(productModel.ecomInventoryId);
                            setState(() {
                              if (quantity == productModel.minQty.round()) {
                                if (hasItemInCart) {
                                  quantity++;
                                  productModel.quantity = quantity;
                                  SQLiteDbProvider.db
                                      .update(productModel, 1, 0);
                                  _showToast('Item updated in Cart');
                                } else {
                                  productModel.quantity = quantity;
                                  SQLiteDbProvider.db
                                      .insert(productModel, 1, 0);
                                  _showToast('Item added to Cart');
                                  quantity = productModel.minQty.round();
                                }
                              } else {
                                quantity++;
                                productModel.quantity = quantity;
                                SQLiteDbProvider.db.update(productModel, 1, 0);
                                _showToast('Item updated in Cart');
                              }
                            });
                          },
                          child: Text(
                            '+',
                            style: TextStyle(
                                fontSize: 30, color: Color(0xFFff5860)),
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
    );
  }
}
