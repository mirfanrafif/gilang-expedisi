class ProcessJobResponse {
  ProcessJobResponse({
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.soId,
    required this.details,
    required this.user,
    required this.attachments,
  });

  final String? status;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? soId;
  final List<Detail> details;
  final User? user;
  final List<Attachment> attachments;

  factory ProcessJobResponse.fromJson(Map<String, dynamic> json) {
    return ProcessJobResponse(
      status: json["status"],
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      soId: json["so_id"],
      details: json["details"] == null
          ? []
          : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
      user: json["user"] != null ? User.fromJson(json['user']) : null,
      attachments: json["attachments"] == null
          ? []
          : List<Attachment>.from(
              json["attachments"]!.map((x) => Attachment.fromJson(x))),
    );
  }
}

class User {
  User({
    required this.isActive,
    required this.isTrash,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
    required this.fullName,
  });

  final bool? isActive;
  final bool? isTrash;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? firstName;
  final dynamic lastName;
  final String? role;
  final String? email;
  final String? fullName;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      isActive: json["is_active"],
      isTrash: json["is_trash"],
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      firstName: json["first_name"],
      lastName: json["last_name"],
      role: json["role"],
      email: json["email"],
      fullName: json["full_name"],
    );
  }
}

class Attachment {
  Attachment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? url;

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      url: json["url"],
    );
  }
}

class Detail {
  Detail({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.weight,
    required this.head,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? productId;
  final int? weight;
  final int? head;

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      productId: json["product_id"],
      weight: json["weight"],
      head: json["head"],
    );
  }
}
