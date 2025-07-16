
import 'package:floor/floor.dart';
import 'ShoppingItem.dart'; //:8a

/**
 * DAO component responsible for managing access to underlying SQLite DB. The abstract class contains method signatures
 * for querying the DB which have to return a Future ir Stream.
 * This is the skeleton.
 */
@dao // mark this as DAO :6
abstract class ShoppingItemDAO{ // needs to be abstract class cos Floor will code all functions for you :5

  // create a query function to get your objects: 7
  @Query("Select * from ShoppingItem ") // entity is table name, this case is ShoppingItem :7
  Future< List < ShoppingItem > > getAllShoppingItems();  // returns a list of entity *also import the entity class :8
      // no function body in this abstract class. Floor will generate :8b

  // insert query. must be Future to mark async :9
  @insert
  Future < void > addShoppingItem ( ShoppingItem toBeInserted );

  // delete query. :10
  @delete
  Future < void > deleteShoppingItem ( ShoppingItem tobeDeleted );

  // update query. not used in this lab.
  //@update
  //Future < void > updateShoppingItem ( ShoppingItem tobeUpdated ); // by id =


}