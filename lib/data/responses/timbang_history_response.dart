import 'package:aplikasi_timbang/data/responses/job_process_response.dart';

class JobHistoryResponse {
  JobHistoryResponse({
    required this.data,
    required this.meta,
    required this.links,
  });

  final List<ProcessJobResponse> data;
  final Meta? meta;
  final Links? links;

  factory JobHistoryResponse.fromJson(Map<String, dynamic> json) {
    return JobHistoryResponse(
      data: json["data"] == null
          ? []
          : List<ProcessJobResponse>.from(
              json["data"]!.map((x) => ProcessJobResponse.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
    );
  }
}

class Links {
  Links({
    required this.current,
  });

  final String? current;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      current: json["current"],
    );
  }
}

class Meta {
  Meta({
    required this.itemsPerPage,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
    required this.sortBy,
  });

  final int? itemsPerPage;
  final int? totalItems;
  final int? currentPage;
  final int? totalPages;
  final List<List<String>> sortBy;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      itemsPerPage: json["itemsPerPage"],
      totalItems: json["totalItems"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      sortBy: json["sortBy"] == null
          ? []
          : List<List<String>>.from(json["sortBy"]!.map(
              (x) => x == null ? [] : List<String>.from(x!.map((x) => x)))),
    );
  }
}
