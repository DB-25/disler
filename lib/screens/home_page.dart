import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:qirana_app/components/horizontal_category.dart';
import 'package:qirana_app/components/vertical_item_view.dart';
import 'package:qirana_app/components/horizontal_item_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  images: [
                    NetworkImage(
                        'https://www.treehugger.com/thmb/oVLB_Em5OBGo8Qc5M9i8g4lg2bM=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__treehugger__images__2020__04__grocery-cart-a12224a52f8f4e42a3a5464cfe0caa28.jpg'),
                    NetworkImage(
                        'https://image.cnbcfm.com/api/v1/image/105964943-1560377013grocery-store-header.png?v=1561046400&w=1400&h=950'),
                    NetworkImage(
                        'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80')
                  ],
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
              SizedBox(
                height: 10,
              ),
              HorizontalCategory(),
              SizedBox(
                height: 10,
              ),
              HorizontalView(
                title: 'BEST DEALS',
                axisDirection: Axis.horizontal,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'POPULAR THIS WEEK',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
              VerticalView(),
            ],
          ),
        ),
      ),
    );
  }
}
