import 'package:aplikasi_timbang/data/database/db_helper.dart';
import 'package:aplikasi_timbang/data/models/produk.dart';

class Timbang {
  int? _id;
  int _soId = 0;
  int _supirId = 0;
  String _namaKandang = '';
  String _alamatKandang = '';
  DateTime _createdAt = DateTime.now();
  bool syncWithApi = false;

  final List<TimbangProduk> _listProduk = [];

  static const String _tableName = 'timbang';

  int? get id => _id;
  int get soId => _soId;
  int get supirId => _supirId;
  String get alamatKandang => _alamatKandang;
  String get namaKandang => _namaKandang;
  DateTime get createdAt => _createdAt;
  List<TimbangProduk> get listProduk => List.unmodifiable(_listProduk);

  set listProduk(List<TimbangProduk> newProduk) {
    _listProduk.clear();
    _listProduk.addAll(newProduk);
  }

  Timbang(this._soId, this._supirId, this._namaKandang, this._alamatKandang);

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
    syncWithApi = map['sync_with_api'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = _id;
    map['nomor_so'] = _soId;
    map['supir_id'] = _supirId;
    map['nama_kandang'] = _namaKandang;
    map['alamat_kandang'] = _alamatKandang;
    map['sync_with_api'] = syncWithApi;
    return map;
  }

  Future<void> save() async {
    var dbHelper = DbHelper();
    if (_id != null) {
      var result = await dbHelper.update(_tableName, toMap(), _id!);

      _id = result;
    } else {
      var result = await dbHelper.insert(_tableName, toMap());

      _id = result;
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
      var listProduk = await TimbangProduk.getByTimbangId(timbang.id!);
      timbang.listProduk = listProduk;
    }

    return listTimbang;
  }

  Future<int> delete() async {
    var dbHelper = DbHelper();
    if (_id != null) {
      var result = await dbHelper.delete(_tableName, _id!);
      return result;
    }
    return 0;
  }
}
