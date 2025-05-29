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
  // stack item generator
  Widget generateStackItem(
    String image,
    String title,
    AlignmentGeometry alignment,
  ) {
    return Stack(
      //component 1
      alignment: alignment,
      children: [
        CircleAvatar(backgroundImage: AssetImage(image), radius: 50),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // list meat items
  List<(String title, String image)> meats = [
    ('BEEF', 'images/beef.jpg'),
    ('CHICKEN', 'images/chicken.jpg'),
    ('PORK', 'images/pork.jpg'),
    ('SEAFOOD', 'images/seafood.jpg'),
  ];

  // generate meat items
  List<Widget> generateRow() {
    return meats
        .map(
          (data) =>
              generateStackItem(data.$2, data.$1, AlignmentDirectional.center),
        )
        .toList();
  }

  // list course items
  List<(String title, String image)> course = [
    ('Main Dishes', 'images/maindishes.jpg'),
    ('Salad Recipes', 'images/salad.jpg'),
    ('Side Dishes', 'images/sidedishes.jpg'),
    ('Crockpot', 'images/cp.jpg'),
  ];

  // generate course items
  List<Widget> generateCourse() {
    return course
        .map(
          (data) => generateStackItem(
            data.$2,
            data.$1,
            AlignmentDirectional.bottomEnd,
          ),
        )
        .toList();
  }

  // list dessert items
  List<(String title, String image)> dessert = [
    ('Ice Cream', 'images/icecream.jpg'),
    ('Brownie', 'images/brownie.jpg'),
    ('Pie', 'images/pie.jpg'),
    ('Cookie', 'images/cookie.jpg'),
  ];

  // generate course items
  List<Widget> generateDessert() {
    return dessert
        .map(
          (data) =>
              generateStackItem(data.$2, data.$1, AlignmentDirectional.center),
        )
        .toList();
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Header
            Text(
              "BROWSE CATEGORIES",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),

            // description
            Text(
              "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories",
              style: TextStyle(fontSize: 15),
            ),

            // MEAT SECTION
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
              child: Text(
                "BY MEAT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: generateRow(),
            ),

            // COURSE SECTION
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
              child: Text(
                "BY COURSE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: generateCourse(),
            ),

            // DESSERT SECTION
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
              child: Text(
                "BY DESSERT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: generateDessert(),
            ),
          ],
        ),
      ),
    );
  }

  // method to generate and return a list of widget
  // List<Widget> generateMeat () {
  //   return [
  //    generateStackItem("images/beef.jpg", "BEEF", AlignmentDirectional.center)
  //  ];
  // }
}
