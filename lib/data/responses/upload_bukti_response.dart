import 'package:aplikasi_timbang/data/responses/login_response.dart';

class UploadBuktiResponse {
  UploadBuktiResponse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.mimetype,
    required this.size,
    required this.originalName,
    required this.fileName,
    required this.url,
    required this.uploader,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? mimetype;
  final String? size;
  final String? originalName;
  final String? fileName;
  final String? url;
  final User? uploader;

  factory UploadBuktiResponse.fromJson(Map<String, dynamic> json) {
    return UploadBuktiResponse(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      mimetype: json["mimetype"],
      size: json["size"],
      originalName: json["original_name"],
      fileName: json["file_name"],
      url: json["url"],
      uploader:
          json["uploader"] == null ? null : User.fromJson(json["uploader"]),
    );
  }
}
