import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  double _counter = 0;
  late TextEditingController _inputController; //this is to read what was typed
  late TextEditingController _quantityController;

  List<String> words = []; //create an empty array for items
  List<String> quantities = [];

  var isChecked = false;

  @override
  void initState() {
    //similar to onloaded=
    super.initState();
    _inputController = TextEditingController();
    _quantityController = TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _quantityController.dispose();
    super.dispose(); // free the memory of what was typed
  }

  void _incrementCounter() {
    setState(() {
      if (_counter < 99.0) _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text("CST2335 page - Lab6"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: ListPage(), //<< Today's topic
        ),
      ),
    );
  }

  Widget ListPage() {
    //put our layout in here

    return Column(
      children: [
        Row(
          children: [


            Expanded(
              child: TextField(
                controller: _inputController,
                decoration: InputDecoration(
                  hintText: 'Type the item here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),


            Expanded(
              child: TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  hintText: 'Type quantity here',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                TextInputType.number, // number keyboard for quantity
              ),
            ),

            ElevatedButton(
              child: Text("Add item"),
              onPressed: () {
                setState(() {
                  var input = _inputController.text.trim();
                  var qty = _quantityController.text.trim();
                  if (input.isNotEmpty && qty.isNotEmpty) {
                    words.add(input);
                    quantities.add(qty); // add the quantity to quantities too
                    _inputController.text = "";
                    _quantityController.text = "";
                  }
                });
              },
            ),

          ],
        ),

        Expanded(
          child: words.isEmpty ?
          Center (
            child: Text("There are no items in the list",
              style: TextStyle(fontSize: 18),
            ),
          )
              : ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, rowNumber) {
              return GestureDetector(
                onTap: () {},
                onHorizontalDragUpdate: (details) {
                  if (((details.primaryDelta!) *
                      (details.primaryDelta!)) >
                      100.0)
                    setState(() {
                      words.removeAt(rowNumber);
                    });
                },
                //details contains how far finger has swiped
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete item"),
                        content: Text(
                            "Are you sure you want to delete '${words[rowNumber]}'?"),
                        actions: [
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Just close the dialog
                            },
                          ),
                          TextButton(
                            child: Text("Yes"),
                            onPressed: () {
                              setState(() {
                                words.removeAt(rowNumber);
                                quantities.removeAt(rowNumber); // keep both lists in sync
                              });
                              Navigator.of(context).pop(); // Close the dialog after deletion
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " ${rowNumber + 1}: ${words[rowNumber]} quantity: ${quantities[rowNumber]}",
                    ),
                    //Text("Item: $rowNumber is ${quantities[rowNumber]}"), // just do the same like word but make it quantities.
                  ],
                ),
              );
            },
          ), //create our ListView
        ),
      ],
    );
  }

  void setNewValue(double value) {
    setState(() {
      _counter = value;
    }); //update the GUI to new values
  }

  void buttonClicked() {}
}
