import 'dart:convert';

class PublishedProducts {
  String? id;
  Bootcamp? bootcamp;
  List<Category>? categories;
  Seller? seller;
  int? sales;
  bool? purchased;
  DateTime? createdAt;
  DateTime? modifiedAt;
  String? sellerId;
  String? productType;
  String? name;
  int? price;
  String? currency;
  String? status;
  bool? deleted;
  String? slug;
  String? classGroupChat;
  dynamic closeDate;
  bool? closed;
  dynamic updatedBy;
  List<String>? tags;

  PublishedProducts({
    this.id,
    this.bootcamp,
    this.categories,
    this.seller,
    this.sales,
    this.purchased,
    this.createdAt,
    this.modifiedAt,
    this.sellerId,
    this.productType,
    this.name,
    this.price,
    this.currency,
    this.status,
    this.deleted,
    this.slug,
    this.classGroupChat,
    this.closeDate,
    this.closed,
    this.updatedBy,
    this.tags,
  });

  factory PublishedProducts.fromMap(Map<String, dynamic> map) =>
      PublishedProducts(
        id: map["id"],
        bootcamp: Bootcamp.fromMap(map["bootcamp"]),
        categories: List<Category>.from(
            map["categories"].map((x) => Category.fromMap(x))),
        seller: Seller.fromMap(map["seller"]),
        sales: map["sales"]?.toInt(),
        purchased: map["purchased"],
        createdAt: DateTime.parse(map["created_at"]),
        modifiedAt: DateTime.parse(map["modified_at"]),
        sellerId: map["seller_id"],
        productType: map["product_type"],
        name: map["name"],
        price: map["price"]?.toInt(),
        currency: map["currency"],
        status: map["status"],
        deleted: map["deleted"],
        slug: map["slug"],
        classGroupChat: map["class_group_chat"],
        closeDate: map["close_date"],
        closed: map["closed"],
        updatedBy: map["updated_by"],
        tags: List<String>.from(map["tags"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bootcamp": bootcamp!.toMap(),
        "categories": List<dynamic>.from(categories!.map((x) => x.toMap())),
        "seller": seller!.toMap(),
        "sales": sales,
        "purchased": purchased,
        "created_at": createdAt!.toIso8601String(),
        "modified_at": modifiedAt!.toIso8601String(),
        "seller_id": sellerId,
        "product_type": productType,
        "name": name,
        "price": price,
        "currency": currency,
        "status": status,
        "deleted": deleted,
        "slug": slug,
        "class_group_chat": classGroupChat,
        "close_date": closeDate,
        "closed": closed,
        "updated_by": updatedBy,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
      };

  String toJson() => json.encode(toMap());

  factory PublishedProducts.fromJson(String source) => PublishedProducts.fromMap(json.decode(source));
}

class Bootcamp {
  String? id;
  DateTime? createdAt;
  DateTime? modifiedAt;
  String? instructorId;
  List<InstructorsId>? instructorsIds;
  String? displayImage;
  String? classTitle;
  String? summary;
  String? courseDescription;
  DateTime? startDate;
  DateTime? endDate;
  int? classSize;
  int? price;
  String? currency;
  String? difficultyLevel;
  List<String>? learningGoals;
  List<String>? classRequirements;
  List<String>? benefits;
  int? assignmentPercentage;
  String? product;

  Bootcamp({
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.instructorId,
    this.instructorsIds,
    this.displayImage,
    this.classTitle,
    this.summary,
    this.courseDescription,
    this.startDate,
    this.endDate,
    this.classSize,
    this.price,
    this.currency,
    this.difficultyLevel,
    this.learningGoals,
    this.classRequirements,
    this.benefits,
    this.assignmentPercentage,
    this.product,
  });

  factory Bootcamp.fromMap(Map<String, dynamic> map) => Bootcamp(
        id: map["id"],
        createdAt: DateTime.parse(map["created_at"]),
        modifiedAt: DateTime.parse(map["modified_at"]),
        instructorId: map["instructor_id"],
        instructorsIds: List<InstructorsId>.from(
            map["instructors_ids"].map((x) => InstructorsId.fromMap(x))),
        displayImage: map["display_image"],
        classTitle: map["class_title"],
        summary: map["summary"],
        courseDescription: map["course_description"],
        startDate: DateTime.parse(map["start_date"]),
        endDate: DateTime.parse(map["end_date"]),
        classSize: map["class_size"],
        price: map["price"]?.toInt(),
        currency: map["currency"],
        difficultyLevel: map["difficulty_level"],
        learningGoals: List<String>.from(map["learning_goals"].map((x) => x)),
        classRequirements:
            List<String>.from(map["class_requirements"].map((x) => x)),
        benefits: List<String>.from(map["benefits"].map((x) => x)),
        assignmentPercentage: map["assignment_percentage"],
        product: map["product"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "modified_at": modifiedAt!.toIso8601String(),
        "instructor_id": instructorId,
        "instructors_ids":
            List<String>.from(instructorsIds!.map((x) => x.toMap())),
        "display_image": displayImage,
        "class_title": classTitle,
        "summary": summary,
        "course_description": courseDescription,
        "start_date": startDate!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "class_size": classSize,
        "price": price,
        "currency": currency,
        "difficulty_level": difficultyLevel,
        "learning_goals": List<String>.from(learningGoals!.map((x) => x)),
        "class_requirements":
            List<String>.from(classRequirements!.map((x) => x)),
        "benefits": List<String>.from(benefits!.map((x) => x)),
        "assignment_percentage": assignmentPercentage,
        "product": product,
      };
}

class InstructorsId {
  String? id;
  String? bio;
  String? bank;
  String? email;
  bool? seller;
  String? country;
  String? username;
  String? bankCode;
  String? imageUrl;
  String? lastName;
  String? firstName;
  String? bankAccountName;
  String? bankAccountNumber;

  InstructorsId({
    this.id,
    this.bio,
    this.bank,
    this.email,
    this.seller,
    this.country,
    this.username,
    this.bankCode,
    this.imageUrl,
    this.lastName,
    this.firstName,
    this.bankAccountName,
    this.bankAccountNumber,
  });

  factory InstructorsId.fromMap(Map<String, dynamic> map) => InstructorsId(
        id: map["id"],
        bio: map["bio"],
        bank: map["bank"],
        email: map["email"],
        seller: map["seller"],
        country: map["country"],
        username: map["username"],
        bankCode: map["bank_code"],
        imageUrl: map["image_url"],
        lastName: map["last_name"],
        firstName: map["first_name"],
        bankAccountName: map["bank_account_name"],
        bankAccountNumber: map["bank_account_number"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bio": bio,
        "bank": bank,
        "email": email,
        "seller": seller,
        "country": country,
        "username": username,
        "bank_code": bankCode,
        "image_url": imageUrl,
        "last_name": lastName,
        "first_name": firstName,
        "bank_account_name": bankAccountName,
        "bank_account_number": bankAccountNumber,
      };
}

class Category {
  String? id;
  DateTime? createdAt;
  DateTime? modifiedAt;
  String? name;
  String? slug;
  String? type;

  Category({
    this.id,
    this.createdAt,
    this.modifiedAt,
    this.name,
    this.slug,
    this.type,
  });

  factory Category.fromMap(Map<String, dynamic> map) => Category(
        id: map["id"],
        createdAt: DateTime.parse(map["created_at"]),
        modifiedAt: DateTime.parse(map["modified_at"]),
        name: map["name"],
        slug: map["slug"],
        type: map["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "modified_at": modifiedAt!.toIso8601String(),
        "name": name,
        "slug": slug,
        "type": type,
      };
}

class Seller {
  String? id;
  String? email;
  String? username;
  String? imageUrl;
  String? firstName;
  String? lastName;

  Seller({
    this.id,
    this.email,
    this.username,
    this.imageUrl,
    this.firstName,
    this.lastName,
  });

  factory Seller.fromMap(Map<String, dynamic> map) => Seller(
        id: map["id"],
        email: map["email"],
        username: map["username"],
        imageUrl: map["image_url"],
        firstName: map["first_name"],
        lastName: map["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "username": username,
        "image_url": imageUrl,
        "first_name": firstName,
        "last_name": lastName,
      };
}
