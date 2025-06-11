import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart' show EncryptedSharedPreferences;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Start of Week4 Lab'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late TextEditingController _loginController; // read what was typed as login
  late TextEditingController _passwordController; // read what was typed as pass
  var imageSource = 'images/question-mark.png';
  final EncryptedSharedPreferences _eprefs = EncryptedSharedPreferences();



  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController(); //making _controller
    _passwordController = TextEditingController();
    getSharedPreferences();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose(); // free the memory of what was typed
  }

  void getSharedPreferences() async
  {
    // wait until this finishes. needs async:
    //var data = await EncryptedSharedPreferences.getInstance(); // return the SharedPreferences that are loaded (could be any images)

    var str =  await _eprefs.getString("UserLogIn"); // return null if UserlogIn is not there
    var pw =  await _eprefs.getString("UserPass"); // return null if UserlogIn is not there
    if (str.length>0) // found it!
      {
        // get page ready with data on disk
      _loginController.text =  str;
      _passwordController.text = pw;
      }
/*
    // does not need async:
    SharedPreferences.getInstance().then( (data ) {

    });

    var pass =  data.getString("UserPass"); // return null if UserPass is not there
    if (pass != null) // found it!
        {
      // get page ready with data on disk
      _passwordController.text = pass;
    }*/

    // does not need async:
    SharedPreferences.getInstance().then( (data ) {

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            TextField(
                controller: _loginController,
                decoration: InputDecoration(
                    hintText:"Login",
                    border: OutlineInputBorder(),
                    labelText: "Login"
                )
            ),

            TextField(
                controller: _passwordController, obscureText: true,
                decoration: InputDecoration(
                    hintText:"Password",
                    border: OutlineInputBorder(),
                    labelText: "Password"
                )
            ),


            Semantics(child: Image.asset(imageSource, width: 300, height: 300,),),

            ElevatedButton( child:  Text("Login"), onPressed: () {
              String password = _passwordController.text;


              showDialog (context: context,
                builder: (BuildContext context) {

                return AlertDialog(
                  title: const Text('Save?'),
                  content: const Text('Do you want to save this login and password?'),
                  actions: <Widget>[
                    FilledButton(onPressed: () {
                      _eprefs.setString("UserLogIn", _loginController.value.text);
                      _eprefs.setString("UserPass", _passwordController.value.text);


                      Navigator.pop(context);

                      var snackBar = SnackBar( content: Text('Username and Password have been saved and loaded!'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }, child: Text("YES")),


                    ElevatedButton(onPressed: () {
                      Navigator.pop(context);
                      _eprefs.clear();
                      }, child: Text("NO")),


                    OutlinedButton(onPressed: () {Navigator.pop(context);}, child: Text("LATER"))
                  ]// end actions widget
                ); // end AlertDialog


                }); // end showDialog

              setState(() {
                if (password == "QWERTY123") {
                  imageSource = 'images/idea.png';
                } else {
                  imageSource = 'images/stop.png';
                }
              });
            },),
          ],
        ),
      ),
    );
  }

}
