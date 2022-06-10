import 'dart:io';

import 'package:aplikasi_timbang/data/preferences/so_preferences.dart';
import 'package:aplikasi_timbang/data/responses/cari_so_response.dart';
import 'package:aplikasi_timbang/data/responses/job_process_response.dart';
import 'package:aplikasi_timbang/data/responses/upload_bukti_response.dart';
import 'package:aplikasi_timbang/data/services/response.dart';
import 'package:aplikasi_timbang/data/services/so_service.dart';

class SoRepository {
  var service = SoService();
  var preferences = SoPreferences();
  Future<ApiResponse<CariSoResponse?>> cariSo(int soId, String token) {
    return service.findSo(soId, token);
  }

  void setSession(int timbangId) {
    preferences.setTimbangSession(timbangId);
  }

  int? getSession() => preferences.timbangSession;

  void removeSession() {
    preferences.removeTimbangSession();
  }

  Future<ApiResponse<UploadBuktiResponse?>> uploadBukti(
      File file, String token) {
    return service.uploadBuktiVerifikasi(file, token);
  }

  Future<ApiResponse<ProcessJobResponse?>> processJob(
      Map<String, dynamic> request, int jobId, String token) {
    var response = service.processJob(request, jobId, token);
    return response;
  }

  Future<ApiResponse> completeJob(int jobId, String token) {
    return service.completeJob(jobId, token);
  }
}
