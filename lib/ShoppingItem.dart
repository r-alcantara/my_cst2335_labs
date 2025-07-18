

import 'package:floor/floor.dart';

@entity                                            // tells FLoor to create a table called ShoppingItem :2
 class ShoppingItem {
  /*ShoppingItem(int i, String n){   // this is same 4b but long :4a
    id = ID++;
    name = n;
  }*/
  ShoppingItem(this.id, this.name, this.quantity) {
   // constructor (short cut) :4b
   if (this.id > ID) {
    ID = this.id + 1; // in case something is loaded with id > ID :20
   }
  }

  static int ID = 1;                               // belongs to the class to hand out numbers :3

  @primaryKey                                     // tells Floor that this is unique :1
  final int id;
  String name;
  String quantity;



  @override
  String toString() {
   return name; // Or return '$name - $quantity' for more detail
  }
 }