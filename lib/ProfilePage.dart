import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lab2/dataRepository.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:flutter/rendering.dart';

// 1. resources for application.
class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState(); //from below
  } // setState() to update GUI
}

// 2. the layout of application --fill in appBar and body
class ProfilePageState extends State<ProfilePage> {
  //variables
  late String name; // or use empty String
  late TextEditingController _firstName; // read what was typed as login
  late TextEditingController _lastName;
  late TextEditingController _phone;
  late TextEditingController _email;

  final EncryptedSharedPreferences _eprefs = EncryptedSharedPreferences();

  // create listeners
  void firstNameListener() {
    //_eprefs.setString("firstName", _firstName.text);
    saveData(); // save info
  }
  void lastNameListener() {
    //_eprefs.setString("lastName", _lastName.text);
    saveData();
  }
  void phoneListener() {
    //_eprefs.setString("phone", _phone.text);
    saveData();
  }
  void emailListener() {
    //_eprefs.setString("email", _email.text);
    saveData();
  }

  // loadData() opens eprefs, get saved info, put in textfield.
  Future<void> loadData() async {
    String loadFirstName = await _eprefs.getString("firstName") ?? "";
      _firstName.text = loadFirstName;
    String loadLastName = await _eprefs.getString("lastName") ?? "";
      _lastName.text = loadLastName;
    String loadPhone = await _eprefs.getString("phone") ?? "";
      _phone.text = loadPhone;
    String loadEmail = await _eprefs.getString("email") ?? "";
      _email.text = loadEmail;
  }

  // saveData
  Future<void> saveData() async {
    //                      "key": save as , "value": what the user typed
    await _eprefs.setString("firstName", _firstName.text);
    await _eprefs.setString("lastName", _lastName.text);
    await _eprefs.setString("phone", _phone.text);
    await _eprefs.setString("email", _email.text);
  }

  @override
  void initState() {
    super.initState();

    name = DataRepository.loginName; //retrieve what was sent from login in main

    // making _controllers
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _phone = TextEditingController();
    _email = TextEditingController();

    // attach listeners to _controller
    _firstName.addListener(firstNameListener);
    _lastName.addListener(lastNameListener);
    _phone.addListener(phoneListener);
    _email.addListener(emailListener);

    // load saved data
    loadData();
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

            // use Flexible() inside Row() for proper resize on diff devices
            Row(children: [
                Flexible(child: TextField(controller: _firstName,
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
                        launch("sms:${_phone.text}");
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
                    canLaunch("mailto: ${_email.text}").then((itCan) {
                      if (itCan) {
                        launch("mailto: ${_email.text}");
                      } else {
                        var snackBar = SnackBar(
                          content: Text(
                            'you cannot send email from this device',
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  },
                  icon: Icon(Icons.email),
                ),
              ],
            ),

            // save all input fields into secure storage using EncryptedSHaredPreferences.
            OutlinedButton(
              child: Text("Save info"),
              onPressed: () {
                saveData();

                var snackBar = SnackBar(content: Text('Information saved!'));
                // show confirmation message after saving
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),

            // Go back button
            FilledButton(
              child: Text("Go back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            
            // Clear info button
            OutlinedButton(child: Text("Clear info"),
                onPressed: () {
                  _eprefs.clear();
                })
          ],
        ),
      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
