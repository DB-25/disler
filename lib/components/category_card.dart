import 'package:flutter/material.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/screens/vertical_view_page_2.dart';

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  final String categoryId;
  final Color color1;
  final Color color2;
  final IconData icon;
  final String text1;
  final String text2;
  final String url;

  CategoryCard(
      {this.color1,
      this.color2,
      this.icon,
      this.text1,
      this.text2,
      this.categoryId,
      this.url});

  final ApiDriver apiDriver = new ApiDriver();
  final List<ProductModel> productModel = List<ProductModel>();
  List<ProductModel> getData(List data) {
    for (var i = 0; i < data.length; i++) {
      productModel.add(ProductModel.fromMap(data[i]));
    }
    return productModel;
  }

  bool flag = false;

  String getCategoryUrl(String name) {
    if (name == 'Grocery') return 'product-by-category';
    if (name == 'Personal Care') return 'product-by-category';
    if (name == 'Snacks & All') return 'product-by-category';
    if (name == 'Household Items') return 'product-by-category';
    if (name == 'Beverages')
      return 'product-by-category';
    else {
      flag = true;
      return 'product-by-sub-category';
    }
  }

  ApiResponse subCategoryResponse;
  @override
  Widget build(BuildContext context) {
    getCategoryUrl(text1);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          if (!flag)
            subCategoryResponse = await apiDriver.getSubCategory(categoryId);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerticalViewPage2(
                subCategory: (subCategoryResponse == null)
                    ? null
                    : subCategoryResponse.data,
                title: text1,
                url: url,
                extendedUrl: getCategoryUrl(text1),
                bestDeals: null,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            /*Container(
              width: 125,
              height: 85,
              child: Image.network(
                'http://api.fagnum.com/wp//home/ff80818171b2ad0501720ab097fd0006/personal-care/images/personal-care-1.jpg',
                fit: BoxFit.fill,
              )),*/
            Container(
              width: 125,
              height: 85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: color1),
            ),
            Container(
              width: 125,
              height: 85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          icon,
                          color: color2,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              text1,
                              style: TextStyle(color: color2),
                              maxLines: 2,
                              softWrap: true,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
