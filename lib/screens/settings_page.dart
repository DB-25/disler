import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'SETTINGS',
                  style: TextStyle(
                      color: Color(0xFFff5860),
                      fontSize: 35,
                      fontWeight: FontWeight.w900),
                ),
              ),
              ListView(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      title: Text("Country"),
                      trailing: Text(
                        'INDIA',
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text("Language"),
                    trailing: Text(
                      'English',
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text("Notifications"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text("About Us"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text("Terms of Services"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    title: Text("Privacy Policy"),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        //TODO:add logout
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                            color: Color(0xFFff5860),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
