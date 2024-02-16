import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS products(
        id INTEGER PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        image TEXT NOT NULL,
        thumbnail TEXT NOT NULL,
        userId INTEGER NOT NULL
      )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'tr_store.db',
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  static Future<void> insert(Map<String, dynamic> data) async {
    final db = await SQLHelper.db();

    await db.insert(
      'products',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  /// GET All Data using Pagination, 10 at a time:
  static Future<List<Map<String, dynamic>>> getData({int page = 0}) async {
    final db = await SQLHelper.db();
    if (page != 0) {
      final offset = (page - 1) * 10;
      return db.query(
        'products',
        orderBy: 'id ASC',
        limit: 10,
        offset: offset,
      );
    } else {
      return db.query(
        'products',
        orderBy: 'id ASC',
      );
    }
  }

  /// Get a single product by ID
  static Future<Map<String, dynamic>> getProductById(int id) async {
    final db = await SQLHelper.db();
    final result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.first;
  }

  /// Check If DB has data
  static Future<bool> hasData() async {
    final db = await SQLHelper.db();
    final result = await db.query('products');
    return result.isNotEmpty;
  }

  //// -------- SHOPPING CART ------------ ////
  static Future<void> createCartTable(sql.Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS cart(
        id INTEGER PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        thumbnail TEXT NOT NULL,
        userId INTEGER NOT NULL,
        quantity INTEGER NOT NULL
      )""");
  }

  static Future<sql.Database> cartDb() async {
    return sql.openDatabase(
      'shopping_cart.db',
      version: 1,
      onCreate: (db, version) async {
        await createCartTable(db);
      },
    );
  }

  static Future<void> addItemToCart(Map<String, dynamic> data) async {
    final cartDB = await SQLHelper.cartDb();

    /// Check if the item is already in the cart

    final result = await cartDB.query(
      'cart',
      where: 'id = ?',
      whereArgs: [data['id']],
      limit: 1,
    );

    if (result.isNotEmpty) {
      int quantity = result.first['quantity'] as int;
      quantity++;

      await cartDB.update(
        'cart',
        {'quantity': quantity},
        where: 'id = ?',
        whereArgs: [data['id']],
      );
    } else {
      await cartDB.insert(
        'cart',
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    }
  }

  static Future<void> reduceItemFromCart(Map<String, dynamic> data) async {
    final cartDB = await SQLHelper.cartDb();

    /// Check if the item is already in the cart
    final result = await cartDB.query(
      'cart',
      where: 'id = ?',
      whereArgs: [data['id']],
      limit: 1,
    );

    if (result.isNotEmpty) {
      int quantity = result.first['quantity'] as int;

      if (quantity > 1) {
        quantity--;
        await cartDB.update(
          'cart',
          {'quantity': quantity},
          where: 'id = ?',
          whereArgs: [data['id']],
        );
      } else {
        await cartDB.delete(
          'cart',
          where: 'id = ?',
          whereArgs: [data['id']],
        );
        return;
      }
    }
  }

  static Future<List<Map<String, dynamic>>> getCartData() async {
    final cartDB = await SQLHelper.cartDb();
    return cartDB.query('cart');
  }

  static Future<Map<String, dynamic>> getSingleCartItem(int id) async {
    final cartDB = await SQLHelper.cartDb();
    final result = await cartDB.query(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      await cartDB.delete(
        'cart',
        where: 'id = ?',
        whereArgs: [id],
      );
      return {};
    }

    return result.first;
  }

  static Future<void> clearCart() async {
    final cartDB = await SQLHelper.cartDb();
    await cartDB.delete('cart');
  }
}
