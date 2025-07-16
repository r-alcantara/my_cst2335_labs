// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShoppingItemDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ShoppingItemDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $ShoppingItemDatabaseBuilderContract addMigrations(
      List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ShoppingItemDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ShoppingItemDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorShoppingItemDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ShoppingItemDatabaseBuilderContract databaseBuilder(String name) =>
      _$ShoppingItemDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ShoppingItemDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$ShoppingItemDatabaseBuilder(null);
}

class _$ShoppingItemDatabaseBuilder
    implements $ShoppingItemDatabaseBuilderContract {
  _$ShoppingItemDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ShoppingItemDatabaseBuilderContract addMigrations(
      List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ShoppingItemDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ShoppingItemDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ShoppingItemDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ShoppingItemDatabase extends ShoppingItemDatabase {
  _$ShoppingItemDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ShoppingItemDAO? _getDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ShoppingItem` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `quantity` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ShoppingItemDAO get getDAO {
    return _getDAOInstance ??= _$ShoppingItemDAO(database, changeListener);
  }
}

class _$ShoppingItemDAO extends ShoppingItemDAO {
  _$ShoppingItemDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _shoppingItemInsertionAdapter = InsertionAdapter(
            database,
            'ShoppingItem',
            (ShoppingItem item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'quantity': item.quantity
                }),
        _shoppingItemDeletionAdapter = DeletionAdapter(
            database,
            'ShoppingItem',
            ['id'],
            (ShoppingItem item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'quantity': item.quantity
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ShoppingItem> _shoppingItemInsertionAdapter;

  final DeletionAdapter<ShoppingItem> _shoppingItemDeletionAdapter;

  @override
  Future<List<ShoppingItem>> getAllShoppingItems() async {
    return _queryAdapter.queryList('Select * from ShoppingItem',
        mapper: (Map<String, Object?> row) => ShoppingItem(row['id'] as int,
            row['name'] as String, row['quantity'] as String));
  }

  @override
  Future<void> addShoppingItem(ShoppingItem toBeInserted) async {
    await _shoppingItemInsertionAdapter.insert(
        toBeInserted, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteShoppingItem(ShoppingItem tobeDeleted) async {
    await _shoppingItemDeletionAdapter.delete(tobeDeleted);
  }
}
