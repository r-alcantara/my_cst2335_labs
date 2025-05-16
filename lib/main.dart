import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late TextEditingController _passwordController; // read what was typed as login
  var imageSource = 'images/question-mark.png';


  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController(); //making _controller
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose(); // free the memory of what was typed
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
