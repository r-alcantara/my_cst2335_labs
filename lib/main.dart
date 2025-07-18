import 'package:flutter/material.dart';
import 'package:lab2/ShoppingItem.dart';
import 'package:lab2/ShoppingItemDatabase.dart';

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
  late TextEditingController _inputController; //this is to read what was typed
  late TextEditingController _quantityController;

  List<ShoppingItem> words = []; //create an empty array for items // changed <> :19b
  List<String> quantities = [];

  late var myDAO; // use this in several functions so has to be declared as class var :18

  var isChecked = false;

  @override
  void initState() { //similar to onloaded =
    super.initState();
    _inputController = TextEditingController();
    _quantityController = TextEditingController();




    /**
     * open the database :17 the word $Floor, followed by you database. 'app_database.db' must be unique
     *  final database = await $FloorShoppingItemDatabase.databaseBuilder('app_database.db').build();
     *  since we cant use 'await' here cos initState CANT BE ASYNC so must use '.then' notation
     */
    $FloorShoppingItemDatabase.databaseBuilder('app_database.db')
      .build()
        .then ( (database) async { // marked as aync cos inside a function :19

          // by now, database has all the objects:
        myDAO = database.getDAO; // from db, we use DAO object to access db :17a
        //var results = await myDAO.getAllShoppingItems();  // get all objects from db with query: 19a

        myDAO.getAllShoppingItems().then((results) {
          setState(() {
            words = results; // Load items from DB
          });
        });
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _quantityController.dispose();
    super.dispose(); // free the memory of what was typed
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text("CST2335 page - DB lab8"),
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
              onPressed: () async {

                var input = _inputController.text.trim();
                var qty = _quantityController.text.trim();

                if (input.isNotEmpty && qty.isNotEmpty) {
                  var newItem = ShoppingItem(ShoppingItem.ID++, input, qty); // call constructor and increment on what user input :19b

                  // Add to list and update UI
                  setState(() {
                    words.add(newItem);
                    quantities.add(qty);
                  });

                  //words.add(newItem); // add what user typed :19c
                  //quantities.add(qty); // add the quantity to quantities too

                  // Add to database
                  await myDAO.addShoppingItem(newItem); // Add to DB

                  // Clear text fields
                  _inputController.text = "";
                  _quantityController.text = "";
                }
              },
              //child: Text("Add item"),
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
                    setState(() { words.removeAt(rowNumber);});
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
                            onPressed: () async {
                              // Get the item to delete
                              final itemToDelete = words[rowNumber];

                              // Delete from DB
                              await myDAO.deleteShoppingItem(itemToDelete);

                              // Delete from memory
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
                      "Item${rowNumber + 1}: ${words[rowNumber].name} Quantity: ${words[rowNumber].quantity}",
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

  //void setNewValue(double value) {
//    setState(() {
//      _counter = value;
//    }); //update the GUI to new values
//  }

  void buttonClicked() {}
}
