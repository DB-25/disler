import 'package:flutter/material.dart';
import 'package:qirana_app/model/category_model.dart';
import 'category_card.dart';

class HorizontalCategory extends StatefulWidget {
  HorizontalCategory({this.categoryModel, this.showTitle, this.duration});
  final List<CategoryModel> categoryModel;
  final bool showTitle;
  final int duration;

  @override
  _HorizontalCategoryState createState() => _HorizontalCategoryState();
}

class _HorizontalCategoryState extends State<HorizontalCategory> {
  IconData getIcon(String name) {
    if (name == 'Grocery') return Icons.local_mall;
    if (name == 'Personal Care') return Icons.favorite_border;
    if (name == 'Snacks & All') return Icons.fastfood;
    if (name == 'Beverages') return Icons.local_bar;
    return Icons.local_dining;
  }

  Color getColor1(int num) {
    num = num % 5;
    if (num == 0) return Color(0xff066E4B);
    if (num == 1) return Colors.blueAccent;
    if (num == 2) return Colors.brown;
    if (num == 3) return Colors.redAccent;
    if (num == 4) return Color(0xffFEBE50);
    return Color(0xff183B8C);
  }

  Color getColor2(int num) {
    num = num % 5;
    if (num == 0) return Colors.white70;
    if (num == 1) return Colors.white70;
    if (num == 2) return Colors.white70;
    if (num == 3) return Colors.white70;
    if (num == 4) return Colors.white70;
    return Color(0xffF3DCEC);
  }

  bool loading = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: widget.duration), () {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 8),
      child: Container(
        height: (widget.showTitle) ? 125 : 102,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            (widget.showTitle)
                ? Text(
                    'Shop by Categories',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  )
                : Container(),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: widget.categoryModel == null
                    ? Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : loading
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 85,
                                    width: 85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200]),
                                  ),
                                ))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.categoryModel.length,
                            itemBuilder: (BuildContext context, int index) =>
                                CategoryCard(
                                    text1: widget.categoryModel[index].name,
                                    text2:
                                        widget.categoryModel[index].description,
                                    icon: getIcon(
                                        widget.categoryModel[index].name),
                                    color1: getColor1(index),
                                    color2: getColor2(index),
                                    categoryId:
                                        widget.categoryModel[index].categoryId,
                                    url: widget.categoryModel[index].url)))
          ],
        ),
      ),
    );
  }
}
