import 'package:flutter/material.dart';
import 'package:qirana_app/model/inventory_model.dart';

class InventoryItem extends StatelessWidget {
  final InventoryModel inventory;
  InventoryItem(this.inventory);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  inventory.item,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFff5860)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                child: Container(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Price: ' + inventory.price.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          'Unit Price: ' + inventory.unitPrice,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          'Weight: ' + inventory.weight,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Quantity: ' + inventory.quantity.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          'MRP: ' + inventory.mrp.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                        Text(
                          'Buy Date: ' + inventory.buyingDate,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                        Text(
                          inventory.buyerName,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
