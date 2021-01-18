import 'package:flutter/material.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'DELIVERY',
                  style: TextStyle(
                      color: Color(0xFFff5860),
                      fontSize: 35,
                      fontWeight: FontWeight.w900),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xfff6f6f6),
                  child: Icon(
                    Icons.location_on,
                    color: Color(0xFFff5860),
                    size: 30,
                  ),
                ),
                title: Text(
                  'My Address',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.8)),
                ),
                subtitle: Text(
                  '2/21,King St,Redfern NSW 2016',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.black),
                ),
                trailing: Text(
                  'Change',
                  style: TextStyle(
                      color: Color(0xFFff5860),
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          color: Color(0xFFff5860),
                          size: 50,
                        ),
                        Text(
                          'Estimate Delivery Time',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'SUN,NOV 15 2020',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          '10AM - 1PM',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Text(
                  '12 Products',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'View List',
                    style: TextStyle(
                        color: Color(0xFFff5860),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                height: 30,
                child: ListTile(
                  leading: Text(
                    'Sub Total',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    'Rs 1500.00',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: 30,
                child: ListTile(
                  leading: Text(
                    'Delivery Fees',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    'Rs 100.00',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 16),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: ListTile(
                  leading: Text(
                    'Total',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    'Rs 1600.00',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Color(0xFFff5860),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Proceed to payment",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
