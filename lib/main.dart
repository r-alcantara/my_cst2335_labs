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

              showDialog (context: context,
                builder: (BuildContext context) {

                return AlertDialog(
                  title: const Text('Save?'),
                  content: const Text('Do you want to save this login and password?'),
                  actions: <Widget>[
                      ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("NO")),
                      FilledButton(onPressed: () {Navigator.pop(context);}, child: Text("YES")),
                      OutlinedButton(onPressed: () {Navigator.pop(context);}, child: Text("LATER"))
                  ]// end actions widget
                ); // end AlertDialog


                }); // end showDialog


              var snackBar = SnackBar( content: Text('Yay a snackbar!'),
                duration: Duration(seconds: 30),
                action:SnackBarAction( label:'Click Me', onPressed: () {} )
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
