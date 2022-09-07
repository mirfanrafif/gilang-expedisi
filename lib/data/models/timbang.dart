import 'package:aplikasi_timbang/data/database/db_helper.dart';
import 'package:aplikasi_timbang/data/models/produk.dart';

class Timbang {
  int _id = 0;
  int _soId = 0;
  int _supirId = 0;
  String _namaKandang = '';
  String _alamatKandang = '';
  DateTime tanggalPemesanan = DateTime.now();
  DateTime _createdAt = DateTime.now();
  String _status = '';

  final List<TimbangProduk> _listProduk = [];

  static const String _tableName = 'job';

  int get id => _id;

  int get soId => _soId;

  int get supirId => _supirId;

  String get alamatKandang => _alamatKandang;

  String get namaKandang => _namaKandang;

  DateTime get createdAt => _createdAt;

  String get status => _status;

  List<TimbangProduk> get listProduk => List.unmodifiable(_listProduk);

  set listProduk(List<TimbangProduk> newProduk) {
    _listProduk.clear();
    _listProduk.addAll(newProduk);
  }

  Timbang(this._id, this._soId, this._supirId, this._namaKandang,
      this._alamatKandang, this.tanggalPemesanan, this._status);

  static Future<Timbang?> findById(int id) async {
    var dbHelper = DbHelper();
    var result =
        await dbHelper.selectQuery('SELECT * FROM $_tableName WHERE id = $id;');

    if (result.isNotEmpty) {
      var timbang = Timbang.fromMap(result.first);
      return timbang;
    }
    return null;
  }

  void tambahProduk(TimbangProduk produk) {
    _listProduk.add(produk);
  }

  Timbang.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _soId = map['nomor_so'];
    _supirId = map['supir_id'];
    _createdAt = DateTime.parse(map['created_at']);
    _namaKandang = map['nama_kandang'];
    _alamatKandang = map['alamat_kandang'];
    _status = map['status'];
    tanggalPemesanan = DateTime.parse(map['tanggal_pemesanan']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = _id;
    map['nomor_so'] = _soId;
    map['supir_id'] = _supirId;
    map['nama_kandang'] = _namaKandang;
    map['tanggal_pemesanan'] = tanggalPemesanan.toIso8601String();
    map['alamat_kandang'] = _alamatKandang;
    map['status'] = _status;
    return map;
  }

  Future<void> save() async {
    var dbHelper = DbHelper();
    var existingProduk = await findById(id);
    if (existingProduk != null) {
      await dbHelper.update(_tableName, toMap(), id);
    } else {
      await dbHelper.insert(_tableName, toMap());
    }
  }

  static Future<List<Timbang>> getAll() async {
    var dbHelper = DbHelper();
    var result = await dbHelper.selectAll(_tableName);
    var listTimbang = result.map((e) {
      var timbang = Timbang.fromMap(e);
      return timbang;
    }).toList();

    for (var timbang in listTimbang) {
      var listProduk = await TimbangProduk.getByTimbangId(timbang.id);
      timbang.listProduk = listProduk;
    }

    return listTimbang;
  }

  Future<int> delete() async {
    var dbHelper = DbHelper();
    var result = await dbHelper.delete(_tableName, _id);
    return result;
  }
}
