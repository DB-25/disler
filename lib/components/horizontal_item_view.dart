import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qirana_app/components/item_empty.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/screens/vertical_view_page_2.dart';

import 'item_view_vertical.dart';

class HorizontalView extends StatefulWidget {
  final List<ProductModel> productModel;
  final String title;
  final Axis axisDirection;
  final int duration;
  HorizontalView(
      {this.title, this.axisDirection, this.productModel, this.duration});

  @override
  _HorizontalViewState createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<HorizontalView> {
  bool loading = true;
  @override
  void initState() {
    Future.delayed(new Duration(seconds: widget.duration), () {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: (MediaQuery.of(context).size.height < 550) ? 275 : 310,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerticalViewPage2(
                                bestDeals: widget.productModel,
                                url: null,
                                title: 'Best Deals',
                                extendedUrl: null,
                                subCategory: null)));
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFff5860),
                    ),
                  ),
                )
              ],
            ),
            loading
                ? Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemEmpty();
                        }),
                  )
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemViewVertical(
                            productModel: widget.productModel[index],
                            showQuantity: true,
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
