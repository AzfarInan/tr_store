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
}
