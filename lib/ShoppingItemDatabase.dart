
 // Creating a database
// run:" flutter packages pub run build_runner build  " this should create ShoppingItemDatabase.g.dart in the library :16

// required package import :11
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

// import classes you wrote :12
import 'ShoppingItemDAO.dart'; // import Dao
import "ShoppingItem.dart";   // Dao's matching entity

part "ShoppingItemDatabase.g.dart"; // *partial* the generated code will be here :13

@Database( version:2, entities: [ShoppingItem] ) // declare this class as a database. Entities are an [] of ShoppingItem :14
abstract class ShoppingItemDatabase extends FloorDatabase {

  // create a function returning a DAO object :15
  ShoppingItemDAO get getDAO; // generates this function as a getter. ShoppingItemDAO is what gets returned


}