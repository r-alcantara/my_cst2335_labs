import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lab2/dataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:flutter/rendering.dart';

// 1. resources for application
class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState(); //from below
  } // setState() to update GUI
}

// 2. the layout of application --fill in appBar and body
class ProfilePageState extends State<ProfilePage> {
  late String name; // or use empty String
  late TextEditingController _firstName; // read what was typed as login
  late TextEditingController _lastName;
  late TextEditingController _phone;
  late TextEditingController _email;

  final EncryptedSharedPreferences _eprefs = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();

    name = DataRepository.loginName; //retrieve what was sent from login in main

    _firstName = TextEditingController(); //making _controller
    _lastName = TextEditingController();
    _phone = TextEditingController();
    _email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // returns Scaffold for page
    return Scaffold(
      appBar: AppBar(title: Text("Page 2")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            Text("Welcome Back, $name ! This is Page 2"),

            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _firstName,
                    decoration: InputDecoration(
                      hintText: "Enter your first name here",
                      border: OutlineInputBorder(),
                      labelText: "first name",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _lastName,
                    decoration: InputDecoration(
                      hintText: "Enter your last name here",
                      border: OutlineInputBorder(),
                      labelText: "last name",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _phone,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number here",
                      border: OutlineInputBorder(),
                      labelText: "phone number",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    canLaunch("tel: ${_phone.text}").then((itCan) {
                      if (itCan) {
                        launch("tel:${_phone.text}");
                      } else {
                        var snackBar = SnackBar(
                          content: Text('you cannot call from this device'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  },
                  icon: Icon(Icons.phone),
                ),
                IconButton(
                  onPressed: () {
                    canLaunch("sms: ${_phone.text}").then((itCan) {
                      if (itCan) {
                        launch("tel:${_phone.text}");
                      } else {
                        var snackBar = SnackBar(
                          content: Text('you cannot text from this device'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  },
                  icon: Icon(Icons.textsms),
                ),
              ],
            ),

            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: "Enter your email here",
                      border: OutlineInputBorder(),
                      labelText: "email address",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print(_email.text);
                    canLaunch("email: ${_email.text}").then((itCan) {
                      if (itCan) {
                        launch("email: ${_email.text}");
                      } else {
                        var snackBar = SnackBar(
                          content: Text('you cannot email from this device'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  },
                  icon: Icon(Icons.email),
                ),
              ],
            ),

            OutlinedButton(
              child: Text("Save info?"),
              onPressed: () {
                _eprefs.setString("_firstName", _firstName.text); //same as save data()

                _eprefs.setString("_lastName", _lastName.text);

                _eprefs.setString("_phone", _phone.text);

                _eprefs.setString("_email", _email.text);

                var snackBar = SnackBar(content: Text('Information saved!'));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            FilledButton(
              child: Text("Go back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
