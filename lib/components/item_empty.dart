import 'package:flutter/material.dart';

class ItemEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: MediaQuery.of(context).size.height / 6 + 10,
        child: Card(
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5, right: 5),
                child: Center(
                  child: Container(
                      color: Colors.grey[200],
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 3 + 15,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.scaleDown,
                      )),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(color: Colors.grey[200], child: Container()),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    color: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
