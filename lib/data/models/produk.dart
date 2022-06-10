import 'package:aplikasi_timbang/data/models/timbang_detail.dart';

import '../database/db_helper.dart';

class TimbangProduk {
  int _id = 0;
  String _namaProduk = '';
  int _targetBerat = 0;
  int _targetJumlah = 0;
  String? _catatan;
  int _timbangId = 0;
  String? buktiVerifikasi;
  String? buktiVerifikasiUrl;
  bool selesaiTimbang = false;
  DateTime _createdAt = DateTime.now();
  final List<TimbangDetail> _listTimbangDetail = [];
  bool syncWithApi = false;

  int get id => _id;
  String get namaProduk => _namaProduk;
  int get targetBerat => _targetBerat;
  int get targetJumlah => _targetJumlah;
  String? get catatan => _catatan;
  int get timbangId => _timbangId;
  DateTime get createdAt => _createdAt;

  List<TimbangDetail> get listTimbangDetail => _listTimbangDetail;

  static const String _tableName = 'so_product';

  set listTimbangDetail(List<TimbangDetail> newValue) {
    _listTimbangDetail.clear();
    _listTimbangDetail.addAll(newValue);
  }

  //constructor untuk memasukkan ke database
  TimbangProduk(
    this._id,
    this._namaProduk,
    this._targetBerat,
    this._targetJumlah,
    this._catatan,
    this._timbangId,
  );

  static Future<TimbangProduk?> findById(int id) async {
    var dbHelper = DbHelper();
    var queryResult =
        await dbHelper.selectQuery('SELECT * FROM $_tableName WHERE id = $id;');

    if (queryResult.isEmpty) {
      return null;
    }

    var produk = TimbangProduk.fromMap(queryResult.first);

    return produk;
  }

  //convert from database to class
  TimbangProduk.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _namaProduk = map['nama_produk'];
    _targetBerat = map['target_berat'];
    _targetJumlah = map['target_jumlah'];
    _catatan = map['catatan'];
    _timbangId = map['timbang_id'];
    buktiVerifikasi = map['bukti_verifikasi'];
    buktiVerifikasiUrl = map['bukti_verifikasi_url'];
    _createdAt = DateTime.parse(map['created_at']);

    syncWithApi = map['sync_with_api'] == 1 ? true : false;
    selesaiTimbang = map['selesai_timbang'] == 1 ? true : false;
  }

  //convert from class to database
  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {};
    result['id'] = _id;
    result['nama_produk'] = _namaProduk;
    result['target_berat'] = _targetBerat;
    result['target_jumlah'] = _targetJumlah;
    result['catatan'] = _catatan;
    result['timbang_id'] = _timbangId;
    result['selesai_timbang'] = selesaiTimbang;
    result['sync_with_api'] = syncWithApi;
    result['bukti_verifikasi'] = buktiVerifikasi;
    result['bukti_verifikasi_url'] = buktiVerifikasiUrl;
    return result;
  }

  void tambahDetail(TimbangDetail newDetail) {
    _listTimbangDetail.add(newDetail);
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

  static Future<List<TimbangProduk>> getAll() async {
    var dbHelper = DbHelper();
    var result = await dbHelper.selectAll(_tableName);
    return result.map((e) => TimbangProduk.fromMap(e)).toList();
  }

  Future<int> delete() async {
    var dbHelper = DbHelper();
    var result = await dbHelper.delete(_tableName, _id);
    return result;
  }

  static Future<List<TimbangProduk>> getByTimbangId(int timbangId) async {
    var dbHelper = DbHelper();
    var result = await dbHelper
        .selectQuery("SELECT * FROM $_tableName WHERE timbang_id = $timbangId");
    var listProduk = result.map((e) => TimbangProduk.fromMap(e)).toList();
    return listProduk;
  }
}
