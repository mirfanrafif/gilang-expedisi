import '../database/db_helper.dart';

class TimbangDetail {
  int? _id;
  int _berat = 0;
  int _jumlah = 0;
  int? _beratOld;
  int? _jumlahOld;
  int _timbangId = 0;

  int get berat => _berat;
  int get jumlah => _jumlah;
  int? get beratOld => _beratOld;
  int? get jumlahOld => _jumlahOld;
  int? get id => _id;
  int get timbangId => _timbangId;

  set jumlah(int newValue) {
    _jumlahOld = _jumlah;
    _jumlah = newValue;
  }

  set berat(int newValue) {
    _beratOld = _berat;
    _berat = newValue;
  }

  TimbangDetail(this._berat, this._jumlah, this._timbangId);

  static const String _tableName = 'timbang_detail';

  TimbangDetail.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _berat = map['berat'];
    _beratOld = map['berat_old'];
    _jumlahOld = map['jumlah_old'];
    _jumlah = map['jumlah'];
    _timbangId = map['produk_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {};
    result['id'] = _id;
    result['berat'] = _berat;
    result['jumlah'] = _jumlah;
    result['berat_old'] = _beratOld;
    result['jumlah_old'] = _jumlahOld;
    result['produk_id'] = _timbangId;
    return result;
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

  static Future<List<TimbangDetail>> getAll() async {
    var dbHelper = DbHelper();
    var result = await dbHelper.selectAll(_tableName);
    return result.map((e) => TimbangDetail.fromMap(e)).toList();
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
