import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Database? _database;

  /// **Initialize the database**
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  /// **Create the database and tables**
  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shop.db'); // ✅ Updated database name

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart (
            id TEXT PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            image TEXT,
            quantity INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE favourite (  -- ✅ Changed "favourites" to "favourite"
            id TEXT PRIMARY KEY,
            title TEXT,
            price REAL,
            description TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  /// **🔹 Insert a Product into the Cart**
  static Future<int> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    return await db.insert('cart', product, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// **🔹 Get All Cart Products**
  static Future<List<Map<String, dynamic>>> getCartProducts() async {
    final db = await database;
    return await db.query('cart', orderBy: "id");
  }

  /// **🔹 Get All Favourite Products**
  static Future<List<Map<String, dynamic>>> getFavouriteProducts() async {
    final db = await database;
    if (db == null) {
      debugPrint("Database is not initialized");
      return [];
    }
    return await db.query('favourite', orderBy: "id");  // ✅ Changed to "favourite"
  }

  /// **🔹 Get a Product by ID**
  static Future<List<Map<String, dynamic>>> getProductById(String productId) async {
    final db = await database;
    return await db.query('cart', where: "id = ?", whereArgs: [productId]);
  }

  /// **🔹 Update Product Quantity in the Cart**
  static Future<int> updateProduct(String productId, int quantity) async {
    final db = await database;
    final data = {'quantity': quantity};
    return await db.update('cart', data, where: "id = ?", whereArgs: [productId]);
  }

  /// **🔹 Delete a Product from the Cart**
  static Future<void> deleteProduct(String productId) async {
    final db = await database;
    await db.delete("cart", where: "id = ?", whereArgs: [productId]);
  }

  /// **🔹 Delete a Product from Favourites**
  static Future<void> deleteFavourite(String productId) async {
    final db = await database;
    await db.delete("favourite", where: "id = ?", whereArgs: [productId]);
  }

  /// **🔹 Delete the Whole Database (Only for Development)**
  static Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shop.db');
    await deleteDatabase(path);
  }
}
