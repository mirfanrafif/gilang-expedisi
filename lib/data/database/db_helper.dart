import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._singleton();
  static DbHelper? _dbHelper;

  static Database? _database;

  factory DbHelper() {
    return _dbHelper ??= DbHelper._singleton();
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'timbang.db';

    return _database ??=
        await openDatabase(path, version: 2, onCreate: _createDb,
            onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (newVersion > oldVersion) {
        for (var i = oldVersion - 1; i < migrations.length; i++) {
          await db.execute(migrations[i]);
        }
      }
    });
  }

  void _createDb(Database db, int version) async {
    //buat tabel timbang
    await db.execute('''
      CREATE TABLE job(
        id INTEGER PRIMARY KEY NOT NULL,
        nomor_so INTEGER NOT NULL,
        nama_kandang VARCHAR(255) NOT NULL,
        alamat_kandang VARCHAR(255) NOT NULL,
        supir_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE so_product(
        id INTEGER PRIMARY KEY NOT NULL,
        nama_produk INTEGER NOT NULL,
        target_berat INTEGER NOT NULL,
        target_jumlah INTEGER NOT NULL,
        catatan VARCHAR(255),
        timbang_id INTEGER NOT NULL,
        sync_with_api TINYINT DEFAULT 0,
        selesai_timbang TINYINT DEFAULT 0,
        bukti_verifikasi VARCHAR(255) DEFAULT NULL,
        bukti_verifikasi_url VARCHAR(255) DEFAULT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    //buat tabel timbang detail untuk menambah detail timbang
    await db.execute('''
      CREATE TABLE product_detail(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        berat INTEGER NOT NULL,
        berat_old INTEGER,
        jumlah INTEGER NOT NULL,
        jumlah_old INTEGER,
        produk_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  List<String> migrations = [
    'ALTER TABLE job ADD COLUMN tanggal_pemesanan DATETIME NOT NULL'
  ];

  Future<int> insert(String table, Map<String, dynamic> object) async {
    var db = await init();
    int result = await db.insert(table, object);
    return result;
  }

  Future<int> update(String table, Map<String, dynamic> object, int id) async {
    var db = await init();
    int result = await db.update(table, object, where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> selectAll(String table) async {
    var db = await init();
    var result = await db.query(table);
    return result;
  }

  Future<int> delete(String table, int id) async {
    var db = await init();
    var result = db.delete(table, where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> selectQuery(String query) async {
    var db = await init();
    var result = await db.rawQuery(query);
    return result;
  }
}
