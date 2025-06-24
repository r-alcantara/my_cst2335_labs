import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    // returns Scaffold for page
    return Scaffold(
      appBar: AppBar(title: Text("Page 2")),

      body: Center(
        child: Column(
            children: [Text("Welcome Back! [user name from log in page ] //This is Page 2")]
        ),
      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
