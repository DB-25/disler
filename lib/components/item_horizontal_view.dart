import 'package:flutter/material.dart';
import 'package:qirana_app/database/database.dart';
import 'package:qirana_app/model/product_model.dart';

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

  @override
  void initState() {
    quantity = int.parse(productModel.quantity);
    super.initState();
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
          productModel.size,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        trailing: Container(
          height: 100,
          width: 90,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (quantity == 0)
                    ? Text(
                        'Rs ' + productModel.price.round().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      )
                    : Text(
                        'Rs ' +
                            (productModel.price * quantity).round().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17),
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
                        child: FloatingActionButton(
                            elevation: 5,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                if (quantity > 0) quantity--;
                                productModel.quantity = quantity.toString();
                                if (quantity == 0)
                                  SQLiteDbProvider.db
                                      .delete(productModel.productId);
                                else
                                  SQLiteDbProvider.db
                                      .update(productModel, 1, 0);
                              });
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
                          onPressed: () {
                            setState(() {
                              quantity++;
                              productModel.quantity = quantity.toString();
                              if (quantity == 1)
                                SQLiteDbProvider.db.insert(productModel, 1, 0);
                              else
                                SQLiteDbProvider.db.update(productModel, 1, 0);
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
