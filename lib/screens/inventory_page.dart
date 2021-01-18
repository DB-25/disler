import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:qirana_app/components/inventory_item.dart';
import 'package:qirana_app/model/inventory_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/networking/ApiResponse.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  List<InventoryModel> inventory = List<InventoryModel>();
  ApiDriver apiDriver = new ApiDriver();

  void getInventoryDetails(List data) {
    inventory.clear();
    for (var i = 0; i < data.length; i++) {
      inventory.add(InventoryModel.fromMap(data[i]));
    }
    inventory.sort((a, b) {
      var aDate = a.buyingDate;
      var bDate = b.buyingDate;
      return bDate.compareTo(aDate);
    });
  }

  Future<List<InventoryModel>> search(String search) async {
//    await Future.delayed(Duration(seconds: 2));
    ApiResponse response = await apiDriver.getInventory(search);
    getInventoryDetails(response.data);
    return inventory;
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
                child: SearchBar<InventoryModel>(
                  onError: (error) {
                    return Center(
                        child: Text(
                      'No Records Found',
                      style: TextStyle(fontSize: 18),
                    ));
                  },
                  onSearch: search,
                  onItemFound: (InventoryModel inventory, int index) {
                    return InventoryItem(inventory);
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
