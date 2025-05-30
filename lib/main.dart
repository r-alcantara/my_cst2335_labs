import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { //root widget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Lab 3'),
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
  // method creating reusable stack widget
  Widget generateStackItem(String image, String title,
      AlignmentGeometry alignment) {
    return Stack (
      alignment: alignment,
      children: [
        CircleAvatar(backgroundImage: AssetImage(image), radius: 40),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // list of meat items
  List<(String title, String image)> meats = [
    ('BEEF', 'images/beef.jpg'),
    ('CHICKEN', 'images/chicken.jpg'),
    ('PORK', 'images/pork.jpg'),
    ('SEAFOOD', 'images/seafood.jpg'),
  ];

  // list of course items
  List<(String title, String image)> course = [
    ('Main Dishes', 'images/maindishes.jpg'),
    ('Salad Recipes', 'images/salad.jpg'),
    ('Side Dish', 'images/sidedishes.jpg'),
    ('Crockpot', 'images/cp.jpg'),
  ];

  // list of dessert items (tuple)
  List<(String title, String image)> dessert = [
    ('Ice Cream', 'images/icecream.jpg'),
    ('Brownie', 'images/brownie.jpg'),
    ('Pie', 'images/pie.jpg'),
    ('Cookie', 'images/cookie.jpg'),
  ];

  // convert item list (meat, course or dessert) tuple into list of widget
  List<Widget> generateItem(List<(String title, String image)> data,
      AlignmentDirectional alignment) {
    return data
        .map(
          (data) =>
          generateStackItem(
              data.$2, // image
              data.$1, // title
              alignment
          ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),

      body:
      Padding(
        padding: EdgeInsets.fromLTRB(5, 20, 5, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // header
            Text(
              "BROWSE CATEGORIES",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // description
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories",
                style: TextStyle(fontSize: 15),
              ),
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
              children: generateItem(meats, AlignmentDirectional.center),
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
              children: generateItem(course, AlignmentDirectional.bottomCenter),
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
              children: generateItem(
                  dessert, AlignmentDirectional.bottomCenter),
            ),
          ],
        ),
      ),
    );
  }
}