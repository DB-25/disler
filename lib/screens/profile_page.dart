import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qirana_app/screens/chat_screen.dart';
import 'settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('emailId')) emailId = prefs.getString('emailId');
      if (prefs.containsKey('name')) name = prefs.getString('name');
    });
  }

  String emailId = 'qirana@gmail.com';
  String name = 'New User';

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF3DCEC),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        color: Color(0xffFF5858),
                      ),
                    ),
                    // Text(
                    //   'LAST NAME',
                    //   style: TextStyle(
                    //     fontSize: 40,
                    //     fontWeight: FontWeight.w900,
                    //     color: Color(0xffFF5858),
                    //   ),
                    // ),
                    Text(
                      emailId,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Stack(
                  children: <Widget>[
                    ClipOval(
                      child: (_image == null)
                          ? Image.asset(
                              'assets/download.png',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0, left: 60),
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: Color(0xffFfbd50),
                        onPressed: getImage,
                        tooltip: 'Pick Image',
                        child: Icon(Icons.add_a_photo, size: 25),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      title: Text("Profile"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  ListTile(
                    title: Text("My Orders"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  ListTile(
                    title: Text("My Address"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen()));
                    },
                    child: ListTile(
                      title: Text("Help & Supports"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()));
                    },
                    child: ListTile(
                      title: Text("Settings"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: Divider(
                      thickness: 1,
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
