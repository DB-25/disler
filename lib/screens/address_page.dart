import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qirana_app/components/input_field.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/model/order_detail_model.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/screens/order_confirm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  final List<ProductModel> products;
  AddressPage({this.products});
  @override
  _AddressPageState createState() => _AddressPageState(products: products);
}

final _formKey = GlobalKey<FormState>();
final scaffoldKey = GlobalKey<ScaffoldState>();

var formData = {
  'area': '',
  'city': 'Bijnor',
  'contactNumber': '',
  'contestName': 'Second',
  'country': 'India',
  'emailId': '',
  'houseNo': '',
  'name': '',
  'orderId': '',
  'paymentOption': 'Cash on Delivery',
  'paymentOrderId': '',
  'state': 'Uttar Pradesh',
  'referralCode': '',
};

class _AddressPageState extends State<AddressPage> {
  ApiDriver apiDriver = new ApiDriver();
  OrderDetailModel addressDetails;
  final List<ProductModel> products;
  _AddressPageState({this.products});
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
        key: scaffoldKey,
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Delivery Details',
                            style: TextStyle(
                                color: Color(0xFFff5860),
                                fontSize: 28,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.text,
                          hintText: 'Enter your Name',
                          validator: emptyValidator('Enter a Name'),
                          onSaved: (val) => formData['name'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.emailAddress,
                          hintText: 'Enter your Email Id',
                          validator: emailValidator(),
                          onSaved: (val) => formData['emailId'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.number,
                          hintText: 'Enter your Contact Number',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['contactNumber'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.number,
                          hintText: 'Enter your House No',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['houseNo'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InputField(
                          inputType: TextInputType.text,
                          hintText: 'Enter your Area',
                          validator: emptyValidator('Cant be Empty'),
                          onSaved: (val) => formData['area'] = val,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Color(0xfff2f2f2),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 18.0, right: 30, top: 4),
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.black.withOpacity(0.6),
                              value: formData['city'],
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              dropdownColor: Color(0xfff2f2f2),
                              isExpanded: true,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              underline: Container(
                                height: 2,
                                color: Color(0xfff2f2f2),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  formData['city'] = newValue;
                                });
                              },
                              items: <String>[
                                'Bijnor'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Color(0xfff2f2f2),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 18.0, right: 30, top: 4),
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.black.withOpacity(0.6),
                              value: formData['state'],
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              dropdownColor: Color(0xfff2f2f2),
                              isExpanded: true,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              underline: Container(
                                height: 2,
                                color: Color(0xfff2f2f2),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  formData['state'] = newValue;
                                });
                              },
                              items: <String>[
                                'Uttar Pradesh'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Color(0xfff2f2f2),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 18.0, right: 30, top: 4),
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.black.withOpacity(0.6),
                              value: formData['country'],
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              dropdownColor: Color(0xfff2f2f2),
                              isExpanded: true,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              underline: Container(
                                height: 2,
                                color: Color(0xfff2f2f2),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  formData['country'] = newValue;
                                });
                              },
                              items: <String>[
                                'India'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Color(0xfff2f2f2),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 18.0, right: 30, top: 4),
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.black.withOpacity(0.6),
                              value: formData['paymentOption'],
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              dropdownColor: Color(0xfff2f2f2),
                              isExpanded: true,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              underline: Container(
                                height: 2,
                                color: Color(0xfff2f2f2),
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  formData['paymentOption'] = newValue;
                                });
                              },
                              items: <String>[
                                'Cash on Delivery'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        color: Color(0xFFff5860),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Confirm",
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
                        onPressed: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          await prefs.setBool('address_added', true);
                          //print(json.encode(formData));
                          await prefs.setString('address_form_data', json.encode(formData));
                          _formKey.currentState.save();
                          if (!_formKey.currentState.validate()) return;
                          addressDetails = OrderDetailModel.fromMap(formData);
                          ApiResponse response = await apiDriver.orderDetails(
                              orderDetailModel: addressDetails,
                              productModel: products);
                          if (response.data != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderConfirm(
                                          orderNo: response.data[0]['cOrderId'],
                                          products: products,
                                        )));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
