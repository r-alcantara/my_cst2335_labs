import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';



class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState(); //from below
  } // setState() to update GUI
}




  class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

  return Scaffold( appBar: AppBar(title:Text("Page 2"),),


      body: Center (child: Column (children: [ Text("Welcome Back! This is Page 2")],))

    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}