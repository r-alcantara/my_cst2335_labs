import 'package:flutter/material.dart';
import 'package:lab2/DataRepository.dart';
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
  late String name ; // or use empty String


  @override
  void initState() {
    super.initState();

    //retrieve what was sent
    name = DataRepository.loginName;
  }

  @override
  Widget build(BuildContext context) {
    // returns Scaffold for page
    return Scaffold(
      appBar: AppBar(title: Text("Page 2")),

      body: Center(
        child: Column(
            children: [Text("Welcome Back, $name ! This is Page 2")]
        ),

      ),
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
