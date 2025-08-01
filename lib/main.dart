import 'dart:async';

import 'package:flutter/material.dart';
import 'ShoppingItem.dart';
import 'ShoppingItemDatabase.dart';
import 'ShoppingItemDAO.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        //'/profile': (context) => ProfilePage(),
      },
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
  final TextEditingController _itemController = TextEditingController(text: '');

  final TextEditingController _quantityController = TextEditingController(
    text: '',
  );

  ShoppingItemDatabase? database = null;

  ShoppingItem? selectedItem;

  Future<void> initDB() async {
    if (database == null) {
      database = await $FloorShoppingItemDatabase.databaseBuilder('app_database.db').build();
    }
  }

  int mainSmallPage = 0;

  List<ShoppingItem> _listItem = [];

  int count = 100;

  @override
  void initState() {
    super.initState();
    initTodoList();
  }

  Future<void> initTodoList() async {
    await initDB();
    var items = await database?.getDAO.getAllShoppingItems();
    setState(() {
      _listItem = items!;
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _handleAddingItem() async {
    await initDB();
    var item = ShoppingItem(
        ShoppingItem.ID++,
        _itemController.text,
        _quantityController.text
    );
    await database?.getDAO.addShoppingItem(item);
    await initTodoList();
    _itemController.clear();
    _quantityController.clear();
  }

  Future<void> _handleRemoveItem(int? id) async {
    if (id == null) return;
    var item = _listItem.firstWhere((item) => id == item.id);
    await database?.getDAO.deleteShoppingItem(item);
    setState(() {
      initTodoList();
    });
  }

  List<Widget> generateList() {
    return _listItem.asMap().entries.map((entry) {
      int index = entry.key;
      var value = entry.value;
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedItem = value;
          });
          if (MediaQuery.of(context).size.width <= 600) {
            setState(() {
              mainSmallPage = 2;
            });
          }
          // You can show a dialog, delete an item, etc.
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              '${index + 1} ${value.name} quantity: ${value.quantity}',
            ),
          ),
        ),
      );
    }).toList();
  }

  Future<void> handleDeleteItem() async {
    await _handleRemoveItem(selectedItem?.id);
    setState(() {
      selectedItem = null;
    });
    if (MediaQuery.of(context).size.width <= 600) {
      setState(() {
        mainSmallPage = 0;
      });
    }
  }

  ListView generateDetailPage() {
    return ListView(
      children: [
        Row(
            children: [
              Expanded(flex: 1, child: Column(children: generateList(),)),
              if (selectedItem != null) Expanded(flex: 2, child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Id: ${selectedItem?.id}", textAlign: TextAlign.start,),
                  Text("Name: ${selectedItem?.name}"),
                  Text("Quantity: ${selectedItem?.quantity}"),
                  Row(
                    children: [
                      OutlinedButton(onPressed: () => {
                        setState(() {
                          selectedItem = null;
                        })
                      }, child: Text("close")),
                      OutlinedButton(onPressed: () => {
                        handleDeleteItem()
                      }, child: Text("delete")),
                    ],
                  )
                ],
              )
              ),
            ]
        )
      ],
    );
  }

  Widget buildLargeScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _itemController,
                decoration: const InputDecoration(
                  labelText: 'type the item here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'type the quantity here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _handleAddingItem,
              child: const Text('Submit'),
            ),
            Expanded(child: generateDetailPage()),
          ],
        ),
      ),
    );
  }

  Widget routingSmallPage() {
    if (mainSmallPage == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _itemController,
                decoration: const InputDecoration(
                  labelText: 'type the item here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'type the quantity here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _handleAddingItem,
              child: const Text('Click here'),
            ),
            Expanded(child: ListView(children: generateList(),)),
          ],
        ),
      );
    }
    return ListView(
      children: [
        Row(
            children: [
              if (selectedItem != null) Expanded(flex: 2, child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Id: ${selectedItem?.id}", textAlign: TextAlign.start,),
                  Text("Name: ${selectedItem?.name}"),
                  Text("Quantity: ${selectedItem?.quantity}"),
                  Row(
                    children: [
                      OutlinedButton(onPressed: () => {
                        setState(() {
                          mainSmallPage = 0;
                        })
                      }, child: Text("close")),
                      OutlinedButton(onPressed: () => {
                        handleDeleteItem()
                      }, child: Text("delete")),
                    ],
                  )
                ],
              )
              ),
            ]
        )
      ],
    );
  }

  Widget buildSmallScreen() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: routingSmallPage()
    );
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return buildLargeScreen();
    }
    return buildSmallScreen();
  }
}
