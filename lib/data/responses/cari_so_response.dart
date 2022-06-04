class CariSoResponse {
  CariSoResponse({
    required this.data,
    required this.meta,
    required this.links,
  });

  final List<SoResponse> data;
  final Meta? meta;
  final Links? links;

  factory CariSoResponse.fromJson(Map<String, dynamic> json) {
    return CariSoResponse(
      data: json["data"] == null
          ? []
          : List<SoResponse>.from(
              json["data"]!.map((x) => SoResponse.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
    );
  }
}

class SoResponse {
  SoResponse({
    required this.requestDelete,
    required this.paymentStatus,
    required this.isReceived,
    required this.isRecent,
    required this.isFromBalance,
    required this.isApprove,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.number,
    required this.transactionNumber,
    required this.email,
    required this.billingAddress,
    required this.transactionDate,
    required this.invoiceExchangeDate,
    required this.dueDate,
    required this.message,
    required this.notes,
    required this.inventoryNotes,
    required this.deposit,
    required this.shippingRequestDate,
    required this.shippingAddress,
    required this.vehicleNumber,
    required this.driverName,
    required this.shippingCost,
    required this.shippingDate,
    required this.shippingTime,
    required this.shippingMethod,
    required this.offerDate,
    required this.offerValidDate,
    required this.returnDate,
    required this.discount,
    required this.discountType,
    required this.status,
    required this.downPayment,
    required this.products,
    required this.user,
    required this.type,
    required this.account,
    required this.customer,
    required this.purchaseType,
    required this.termOfPayment,
    required this.receivePaymentDetail,
    required this.paymentStatusString,
    required this.warehouse,
    required this.paymentDateString,
    required this.isPaymentComplete,
    required this.remainingBill,
    required this.total,
    required this.totalReturnDiscount,
    required this.totalDepreciationDiscount,
    required this.totalDiscount,
    required this.subTotal,
    required this.returnValue,
    required this.depreciationValue,
    required this.totalPayment,
    required this.totalBalance,
  });

  final bool? requestDelete;
  final bool? paymentStatus;
  final bool? isReceived;
  final bool? isRecent;
  final bool? isFromBalance;
  final bool? isApprove;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? number;
  final String? transactionNumber;
  final String? email;
  final String? billingAddress;
  final DateTime? transactionDate;
  final dynamic invoiceExchangeDate;
  final DateTime? dueDate;
  final String? message;
  final String? notes;
  final String? inventoryNotes;
  final int? deposit;
  final DateTime? shippingRequestDate;
  final String? shippingAddress;
  final String? vehicleNumber;
  final String? driverName;
  final int? shippingCost;
  final DateTime? shippingDate;
  final String? shippingTime;
  final String? shippingMethod;
  final dynamic offerDate;
  final dynamic offerValidDate;
  final dynamic returnDate;
  final int? discount;
  final String? discountType;
  final String? status;
  final int? downPayment;
  final List<ProductElement> products;
  final User? user;
  final Type? type;
  final Account? account;
  final Customer? customer;
  final PurchaseType? purchaseType;
  final TermOfPayment? termOfPayment;
  final List<dynamic> receivePaymentDetail;
  final String? paymentStatusString;
  final dynamic warehouse;
  final String? paymentDateString;
  final bool? isPaymentComplete;
  final int? remainingBill;
  final int? total;
  final int? totalReturnDiscount;
  final int? totalDepreciationDiscount;
  final int? totalDiscount;
  final int? subTotal;
  final int? returnValue;
  final int? depreciationValue;
  final int? totalPayment;
  final int? totalBalance;

  factory SoResponse.fromJson(Map<String, dynamic> json) {
    return SoResponse(
      requestDelete: json["request_delete"],
      paymentStatus: json["payment_status"],
      isReceived: json["is_received"],
      isRecent: json["is_recent"],
      isFromBalance: json["is_from_balance"],
      isApprove: json["is_approve"],
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      number: json["number"],
      transactionNumber: json["transaction_number"],
      email: json["email"],
      billingAddress: json["billing_address"],
      transactionDate: json["transaction_date"] == null
          ? null
          : DateTime.parse(json["transaction_date"]),
      invoiceExchangeDate: json["invoice_exchange_date"],
      dueDate:
          json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
      message: json["message"],
      notes: json["notes"],
      inventoryNotes: json["inventory_notes"],
      deposit: json["deposit"],
      shippingRequestDate: json["shipping_request_date"] == null
          ? null
          : DateTime.parse(json["shipping_request_date"]),
      shippingAddress: json["shipping_address"],
      vehicleNumber: json["vehicle_number"],
      driverName: json["driver_name"],
      shippingCost: json["shipping_cost"],
      shippingDate: json["shipping_date"] == null
          ? null
          : DateTime.parse(json["shipping_date"]),
      shippingTime: json["shipping_time"],
      shippingMethod: json["shipping_method"],
      offerDate: json["offer_date"],
      offerValidDate: json["offer_valid_date"],
      returnDate: json["return_date"],
      discount: json["discount"],
      discountType: json["discount_type"],
      status: json["status"],
      downPayment: json["down_payment"],
      products: json["products"] == null
          ? []
          : List<ProductElement>.from(
              json["products"]!.map((x) => ProductElement.fromJson(x))),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      type: json["type"] == null ? null : Type.fromJson(json["type"]),
      account:
          json["account"] == null ? null : Account.fromJson(json["account"]),
      customer:
          json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      purchaseType: json["purchase_type"] == null
          ? null
          : PurchaseType.fromJson(json["purchase_type"]),
      termOfPayment: json["term_of_payment"] == null
          ? null
          : TermOfPayment.fromJson(json["term_of_payment"]),
      receivePaymentDetail: json["receive_payment_detail"] == null
          ? []
          : List<dynamic>.from(json["receive_payment_detail"]!.map((x) => x)),
      paymentStatusString: json["payment_status_string"],
      warehouse: json["warehouse"],
      paymentDateString: json["payment_date_string"],
      isPaymentComplete: json["is_payment_complete"],
      remainingBill: json["remaining_bill"],
      total: json["total"],
      totalReturnDiscount: json["total_return_discount"],
      totalDepreciationDiscount: json["total_depreciation_discount"],
      totalDiscount: json["total_discount"],
      subTotal: json["sub_total"],
      returnValue: json["return_value"],
      depreciationValue: json["depreciation_value"],
      totalPayment: json["total_payment"],
      totalBalance: json["total_balance"],
    );
  }
}

class Account {
  Account({
    required this.balance,
    required this.level,
    required this.isActive,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.name,
    required this.category,
  });

  final String? balance;
  final int? level;
  final bool? isActive;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? code;
  final String? name;
  final String? category;

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      balance: json["balance"],
      level: json["level"],
      isActive: json["is_active"],
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      code: json["code"],
      name: json["name"],
      category: json["category"],
    );
  }
}

class Customer {
  Customer({
    required this.status,
    required this.isActive,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.balance,
    required this.email,
    required this.address,
    required this.shippingAddress,
    required this.notes,
    required this.dob,
    required this.telephones,
    required this.fullName,
    required this.telephonesArray,
    required this.categoriesString,
  });

  final String? status;
  final bool? isActive;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic code;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? balance;
  final String? email;
  final String? address;
  final String? shippingAddress;
  final String? notes;
  final dynamic dob;
  final String? telephones;
  final String? fullName;
  final List<String> telephonesArray;
  final String? categoriesString;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      status: json["status"],
      isActive: json["is_active"],
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      code: json["code"],
      title: json["title"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      balance: json["balance"],
      email: json["email"],
      address: json["address"],
      shippingAddress: json["shipping_address"],
      notes: json["notes"],
      dob: json["dob"],
      telephones: json["telephones"],
      fullName: json["full_name"],
      telephonesArray: json["telephones_array"] == null
          ? []
          : List<String>.from(json["telephones_array"]!.map((x) => x)),
      categoriesString: json["categories_string"],
    );
  }
}

class ProductElement {
  ProductElement({
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
  final ProductProduct? product;

  factory ProductElement.fromJson(Map<String, dynamic> json) {
    return ProductElement(
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
      amount: double.tryParse(json["amount"].toString()),
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
      product: json["product"] == null
          ? null
          : ProductProduct.fromJson(json["product"]),
    );
  }
}

class ProductProduct {
  ProductProduct({
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
  final dynamic materialId;
  final dynamic supportingProductId;
  final int? supportingProductCount;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;
  final dynamic material;
  final dynamic supportingProduct;

  factory ProductProduct.fromJson(Map<String, dynamic> json) {
    return ProductProduct(
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
      material: json["material"],
      supportingProduct: json["supporting_product"],
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

class PurchaseType {
  PurchaseType({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.name,
    required this.isLock,
    required this.order,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? code;
  final String? name;
  final bool? isLock;
  final int? order;

  factory PurchaseType.fromJson(Map<String, dynamic> json) {
    return PurchaseType(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      code: json["code"],
      name: json["name"],
      isLock: json["is_lock"],
      order: json["order"],
    );
  }
}

class TermOfPayment {
  TermOfPayment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.notes,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final dynamic notes;

  factory TermOfPayment.fromJson(Map<String, dynamic> json) {
    return TermOfPayment(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      name: json["name"],
      notes: json["notes"],
    );
  }
}

class Type {
  Type({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.name,
    required this.defaultMessage,
    required this.group,
    required this.isMenu,
    required this.isLock,
    required this.order,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? code;
  final String? name;
  final dynamic defaultMessage;
  final String? group;
  final bool? isMenu;
  final bool? isLock;
  final int? order;

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      code: json["code"],
      name: json["name"],
      defaultMessage: json["default_message"],
      group: json["group"],
      isMenu: json["is_menu"],
      isLock: json["is_lock"],
      order: json["order"],
    );
  }
}

class User {
  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.isActive,
    required this.fullName,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? employeeId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? username;
  final bool? isActive;
  final String? fullName;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      employeeId: json["employee_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      username: json["username"],
      isActive: json["is_active"],
      fullName: json["full_name"],
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
    required this.search,
    required this.searchBy,
  });

  final int? itemsPerPage;
  final int? totalItems;
  final int? currentPage;
  final int? totalPages;
  final List<List<String>> sortBy;
  final String? search;
  final List<String> searchBy;

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
      search: json["search"],
      searchBy: json["searchBy"] == null
          ? []
          : List<String>.from(json["searchBy"]!.map((x) => x)),
    );
  }
}
