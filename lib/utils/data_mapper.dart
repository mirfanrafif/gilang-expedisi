import 'package:aplikasi_timbang/data/models/produk.dart';
import 'package:aplikasi_timbang/data/models/timbang_detail.dart';

List<Map<String, dynamic>> makeJobProcessRequestItems(
    TimbangProduk produk, List<TimbangDetail> listTimbang) {
  return listTimbang.map((detail) {
    return {
      'product_id': produk.id,
      'weight': detail.berat,
      'head': detail.jumlah
    };
  }).toList();
}

Map<String, dynamic> makeJobProcessRequest(
    List<Map<String, dynamic>> items, String attachment) {
  var request = {
    'items': items,
    'attachments': [attachment]
  };

  return request;
}
