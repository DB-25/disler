import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/components/item_horizontal_view.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  ApiDriver apiDriver = new ApiDriver();
  List<ProductModel> products = List<ProductModel>();
  Future<List<ProductModel>> search(String search) async {
    ApiResponse response = await apiDriver.getProduct(search);
    getProductDetails(response.data);
    return products;
  }

  void getProductDetails(List data) {
    products.clear();
    for (var i = 0; i < data.length; i++) {
      products.add(ProductModel.fromMap(data[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
//                height: 500,
                child: SearchBar(
                  searchBarPadding: EdgeInsets.only(left: 5,right: 5),
                  hintText: 'Search a Product',
                  onSearch: search,
                  onError: (error) {
                    return Center(
                        child: Text(
                      'Item Not Found',
                      style: TextStyle(fontSize: 18),
                    ));
                  },
                  onItemFound: (ProductModel products, int index) {
                    return ItemHorizontalView(
                      product: products,
                    );
                  },
                  minimumChars: 1,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
