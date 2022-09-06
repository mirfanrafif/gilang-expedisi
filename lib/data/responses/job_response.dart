import 'package:aplikasi_timbang/data/responses/cari_so_response.dart';

class ListJobResponse {
  ListJobResponse({
    required this.data,
    required this.meta,
    required this.links,
  });

  final List<JobResponseItem> data;
  final Meta? meta;
  final Links? links;

  factory ListJobResponse.fromJson(Map<String, dynamic> json) {
    return ListJobResponse(
      data: json["data"] == null
          ? []
          : List<JobResponseItem>.from(
              json["data"]!.map((x) => JobResponseItem.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
    );
  }
}

class JobResponseItem {
  JobResponseItem({
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.soId,
    required this.details,
    required this.user,
    required this.attachments,
    required this.so,
  });

  final String? status;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? soId;
  final List<Detail> details;
  final User? user;
  final List<Attachment> attachments;
  final SoResponse? so;

  factory JobResponseItem.fromJson(Map<String, dynamic> json) {
    return JobResponseItem(
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
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      attachments: json["attachments"] == null
          ? []
          : List<Attachment>.from(
              json["attachments"]!.map((x) => Attachment.fromJson(x))),
      so: (json["so"] is String) ? null : SoResponse.fromJson(json["so"]),
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
    required this.histories,
    required this.product,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? productId;
  final int? weight;
  final int? head;
  final List<dynamic> histories;
  final DetailProduct? product;

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
      histories: json["histories"] == null
          ? []
          : List<dynamic>.from(json["histories"]!.map((x) => x)),
      product: json["product"] == null
          ? null
          : DetailProduct.fromJson(json["product"]),
    );
  }
}

class DetailProduct {
  DetailProduct({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.productName,
    required this.description,
    required this.amount,
    required this.returnAmount,
    required this.unit,
    required this.perUnitPrice,
    required this.discount,
    required this.discountType,
    required this.depreciationAction,
    required this.depreciationAmount,
    required this.returnDiscount,
    required this.depreciationDiscount,
    required this.discountValue,
    required this.total,
    required this.product,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? productId;
  final String? productName;
  final String? description;
  final double? amount;
  final int? returnAmount;
  final String? unit;
  final int? perUnitPrice;
  final int? discount;
  final String? discountType;
  final String? depreciationAction;
  final int? depreciationAmount;
  final int? returnDiscount;
  final int? depreciationDiscount;
  final int? discountValue;
  final int? total;
  final Product? product;

  factory DetailProduct.fromJson(Map<String, dynamic> json) {
    return DetailProduct(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      productId: json["product_id"],
      productName: json["product_name"],
      description: json["description"],
      amount: json["amount"].toDouble(),
      returnAmount: json["return_amount"],
      unit: json["unit"],
      perUnitPrice: json["per_unit_price"],
      discount: json["discount"],
      discountType: json["discount_type"],
      depreciationAction: json["depreciation_action"],
      depreciationAmount: json["depreciation_amount"],
      returnDiscount: json["return_discount"],
      depreciationDiscount: json["depreciation_discount"],
      discountValue: json["discount_value"],
      total: json["total"],
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }
}

class Product {
  Product({
    required this.id,
    required this.code,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.stock,
    required this.weightInKg,
    required this.pairCount,
    required this.headCount,
    required this.materialId,
    required this.supportingProductId,
    required this.supportingProductCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.material,
    required this.supportingProduct,
  });

  final int? id;
  final String? code;
  final String? name;
  final int? categoryId;
  final String? description;
  final int? stock;
  final String? weightInKg;
  final int? pairCount;
  final int? headCount;
  final int? materialId;
  final int? supportingProductId;
  final int? supportingProductCount;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  final Material? material;
  final SupportingProduct? supportingProduct;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      categoryId: json["category_id"],
      description: json["description"],
      stock: json["stock"],
      weightInKg: json["weight_in_kg"],
      pairCount: json["pair_count"],
      headCount: json["head_count"],
      materialId: json["material_id"],
      supportingProductId: json["supporting_product_id"],
      supportingProductCount: json["supporting_product_count"],
      isActive: json["is_active"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      material:
          json["material"] == null ? null : Material.fromJson(json["material"]),
      supportingProduct: json["supporting_product"] == null
          ? null
          : SupportingProduct.fromJson(json["supporting_product"]),
    );
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.categoryTypeId,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? categoryTypeId;
  final String? code;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      categoryTypeId: json["category_type_id"],
      code: json["code"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }
}

class Material {
  Material({
    required this.id,
    required this.code,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.stock,
    required this.weightInKg,
    required this.pairCount,
    required this.headCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? code;
  final String? name;
  final int? categoryId;
  final String? description;
  final int? stock;
  final String? weightInKg;
  final int? pairCount;
  final int? headCount;
  final bool? isActive;
  final dynamic createdAt;
  final DateTime? updatedAt;

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      categoryId: json["category_id"],
      description: json["description"],
      stock: json["stock"],
      weightInKg: json["weight_in_kg"],
      pairCount: json["pair_count"],
      headCount: json["head_count"],
      isActive: json["is_active"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}

class SupportingProduct {
  SupportingProduct({
    required this.id,
    required this.code,
    required this.name,
    required this.categoryId,
    required this.capacity,
    required this.size,
    required this.stock,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? code;
  final String? name;
  final int? categoryId;
  final String? capacity;
  final String? size;
  final int? stock;
  final bool? isActive;
  final dynamic createdAt;
  final DateTime? updatedAt;

  factory SupportingProduct.fromJson(Map<String, dynamic> json) {
    return SupportingProduct(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      categoryId: json["category_id"],
      capacity: json["capacity"],
      size: json["size"],
      stock: json["stock"],
      isActive: json["is_active"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
    );
  }
}

class Links {
  Links({
    required this.current,
    required this.next,
    required this.last,
  });

  final String? current;
  final String? next;
  final String? last;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      current: json["current"],
      next: json["next"],
      last: json["last"],
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
