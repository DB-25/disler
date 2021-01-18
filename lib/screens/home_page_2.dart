import 'dart:async';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qirana_app/components/horizontal_category.dart';
import 'package:qirana_app/components/horizontal_item_view.dart';
import 'package:qirana_app/components/icon_btn.dart';
import 'package:qirana_app/components/search_field.dart';
import 'package:qirana_app/components/vertical_item_view.dart';
import 'package:qirana_app/model/banner_model.dart';
import 'package:qirana_app/model/category_model.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/screens/address_page.dart';
import 'package:qirana_app/screens/login_screen.dart';
import 'package:qirana_app/screens/manual_order_page.dart';
import 'package:qirana_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'inventory_page.dart';
import 'search_result.dart';

final ValueNotifier<bool> autoLoginBool = ValueNotifier<bool>(false);

final ValueNotifier<bool> admin = ValueNotifier<bool>(false);

class HomePage2 extends StatefulWidget {
  final BannerModel bannerModel;
  final List<CategoryModel> categoryModel;
  final List<ProductModel> popularProductModel;
  final List<ProductModel> bestDealModel;

  HomePage2({this.bannerModel, this.popularProductModel, this.bestDealModel, this.categoryModel});

  @override
  _HomePage2State createState() => _HomePage2State(
      bannerModel: bannerModel,
      popular: popularProductModel,
      bestDeals: bestDealModel,
      categoryModel: categoryModel);
}

class _HomePage2State extends State<HomePage2> {
  ApiDriver apiDriver = new ApiDriver();
  BannerModel bannerModel;
  List<CategoryModel> categoryModel;
  List<ProductModel> bestDeals;
  List<ProductModel> popular;

  _HomePage2State({this.bannerModel, this.popular, this.bestDeals, this.categoryModel});

  _handleSignOut() {
    _googleSignIn.disconnect();
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    admin.value = prefs.containsKey('admin') ? true : false;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    admin.notifyListeners();
    if (prefs.containsKey('autoLogin')) {
      _googleSignIn.signInSilently();
      autoLoginBool.value = prefs.getBool('autoLogin');
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      autoLoginBool.notifyListeners();
    }
    setState(() {});
  }

  @override
  void initState() {
    autoLogin();

    //
    // for (int i = 0; i < productModelLength; i++) {
    //   if (i < (productModelLength / 2))
    //     bestDeals.add(productModel[i]);
    //   else
    //     popular.add(productModel[i]);

    refresh();
    super.initState();
  }

  void refresh() {
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        loading = false;
      });
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    //int productModelLength = productModel.length;
   // productModel.sublist(0, (productModelLength / 2).floor());
   // popular = productModel.sublist((productModelLength / 2).floor());
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
         Container(width: SizeConfig.screenWidth * 1,
            child: Row(children: [
              Expanded(
                flex:0,
                child: Container(
                child:IconButton(
                  icon: Icon(
                    Icons.segment,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),),),
              Expanded(
                flex:1,
                child:InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchResult()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5, top: 10),
                  child: SearchField(),
                ),
              ),),

              Expanded(
                flex: 0,
                child:Container(
                margin: EdgeInsets.only(left:10,top: 10,right: 0),
                child: IconBtn(
                  icon: Icon(Icons.add_a_photo, color: Colors.black45),
                  press: () {
                    getImage();
                    if (_image != null)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressPage(
                                products: null,
                              )));
                  },
                ),
              ),),

              Expanded(
                flex: 0,
                child:Container(
                margin: EdgeInsets.only(left:5,top: 10,right: 5),
                child: IconBtn(
                  icon: Icon(Icons.notifications_active, color: Colors.black45),
                  press: () {},
                ),
              ),),

            ],),),

           /*IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchResult()));
              }),*/


           /*IconButton(
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
              onPressed: () {
                getImage();
                if (_image != null)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressPage(
                                products: null,
                              )));
              }),*/

          ],
          elevation: 0,
          leading: Container(),
          /*leading: IconButton(
            icon: Icon(
              Icons.segment,
              color: Colors.black54,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),*/
          /* title: Text(
            'Qirana',
            style: TextStyle(color: Colors.black54),
          ),*/
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.only(top: 32),
            children: <Widget>[
              Container(
                  color: Colors.white,
                  child: Image.asset(
                    'assets/banner.jpg',
                    fit: BoxFit.fill,
                  )),
              /*Text(
                      'Qirana',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),*/

              ValueListenableBuilder<bool>(
                  valueListenable: autoLoginBool,
                  builder: (BuildContext context, bool value, Widget child) {
                    return (value)
                        ? Container()
                        : ListTile(
                      title: Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    );
                  }),
              ValueListenableBuilder<bool>(
                  valueListenable: admin,
                  builder: (BuildContext context, bool value, Widget child) {
                    return (value)
                        ? ListTile(
                      title: Text(
                        'Check Inventory',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Inventory()));
                      },
                    )
                        : Container();
                  }),
              ListTile(
                title: Text(
                  'Shop by Category',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text(
                  'Order',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ManualOrder()));
                },
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: autoLoginBool,
                  builder: (BuildContext context, bool value, Widget child) {
                    return (value)
                        ? ListTile(
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFff5860),
                            fontWeight: FontWeight.w700),
                      ),
                      onTap: () async {
                        setState(() {
                          _handleSignOut();
                        });
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        autoLoginBool.value = false;
                        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                        autoLoginBool.notifyListeners();
                        await prefs.clear();
                        admin.value = false;
                        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                        admin.notifyListeners();
                        setState(() {});
                      },
                    )
                        : Container();
                  }),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                categoryModel == null
                    ? Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                )
                    : HorizontalCategory(
                  showTitle: false,
                  categoryModel: categoryModel,
                  duration: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SizedBox(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      child: loading
                          ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                          : Carousel(
                        images: [
                          NetworkImage(
                              ApiDriver().getBaseUrl()+'/wp/home/ff80818171b2ad0501720ab097fd0006/bannerOne/banner-one.png'),
                          NetworkImage(
                              ApiDriver().getBaseUrl()+'/wp/home/ff80818171b2ad0501720ab097fd0006/bannerTwo/banner-2.jpg'),
                          NetworkImage(
                              ApiDriver().getBaseUrl()+'/wp/home/ff80818171b2ad0501720ab097fd0006/bannerThree/banner-3.png')
                        ],
                        boxFit: BoxFit.fill,
                        showIndicator: true,
                        dotIncreaseSize: 1.3,
                        dotBgColor: Colors.black.withOpacity(0),
                        dotColor: Colors.white70,
                        borderRadius: false,
                        moveIndicatorFromBottom: 180.0,
                        noRadiusForIndicator: true,
                        overlayShadow: false,
                        overlayShadowColors: Colors.white,
                        overlayShadowSize: 0.7,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                bestDeals == null
                    ? Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                )
                    : HorizontalView(
                  productModel: bestDeals,
                  title: 'Best Deals',
                  axisDirection: Axis.horizontal,
                  duration: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Popular this week',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                ),
                popular == null
                    ? Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                )
                    : VerticalView(
                  productModel: popular,
                  duration: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
