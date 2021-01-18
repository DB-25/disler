import 'package:flutter/material.dart';
import 'package:qirana_app/components/vertical_item_view.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/database/database.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  List<ProductModel> products = List();
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoading = false;

  void getData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      products = await SQLiteDbProvider.db.getFav();
      setState(() {
        isLoading = false;
      });
    }
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {});
    });
    Future.delayed(new Duration(seconds: 2), () {
      setState(() {});
    });
    Future.delayed(new Duration(seconds: 3), () {
      setState(() {});
    });
    Future.delayed(new Duration(seconds: 5), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Text('Favourites',
                      style: TextStyle(
                          color: Color(0xFFff5860),
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  (isLoading)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Center(
                            child: new CircularProgressIndicator(),
                          ),
                        )
                      : (products.isEmpty)
                          ? Container(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'No Items in Favorite',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                            )
                          : VerticalView(
                              productModel: products,
                              duration: 1,
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
