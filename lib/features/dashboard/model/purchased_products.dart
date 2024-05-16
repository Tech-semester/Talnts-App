import 'dart:convert';

class PurchasedProduct {
  final String id;
  final Product product;
  final Buyer buyer;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String status;
  final double price;
  final String currency;

  PurchasedProduct({
    required this.id,
    required this.product,
    required this.buyer,
    required this.createdAt,
    required this.modifiedAt,
    required this.status,
    required this.price,
    required this.currency,
  });

  factory PurchasedProduct.fromJson(Map<String, dynamic> json) {
    return PurchasedProduct(
      id: json['id'] ?? '',
      product: Product.fromJson(json['product'] ?? {}),
      buyer: Buyer.fromJson(json['buyer'] ?? {}),
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      modifiedAt: DateTime.parse(json['modified_at'] ?? ''),
      status: json['status'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
    );
  }
}

class Product {
  final String id;
  final Bootcamp bootcamp;
  final List<Category> categories;
  final List<Tag> tags;
  final Seller seller;
  final List<Instructor> instructors;

  Product({
    required this.id,
    required this.bootcamp,
    required this.categories,
    required this.tags,
    required this.seller,
    required this.instructors,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      bootcamp: Bootcamp.fromJson(json['bootcamp'] ?? {}),
      categories: List<Category>.from((json['categories'] ?? []).map((x) => Category.fromJson(x))),
      tags: List<Tag>.from((json['tags'] ?? []).map((x) => Tag.fromJson(x))),
      seller: Seller.fromJson(json['seller'] ?? {}),
      instructors: List<Instructor>.from((json['instructors'] ?? []).map((x) => Instructor.fromJson(x))),
    );
  }
}

class Bootcamp {
  final String id;
  final List<LiveClassDay> liveClassDays;
  final List<Curriculum> curriculum;
  final List<Faq> faqs;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String instructorId;
  final String displayImage;
  final String classTitle;
  final String summary;
  final String courseDescription;
  final DateTime startDate;
  final DateTime endDate;
  final int classSize;
  final double price;
  final String currency;
  final String difficultyLevel;
  final List<String> learningGoals;
  final List<String> classRequirements;
  final List<String> benefits;
  final int assignmentPercentage;
  final String product;

  Bootcamp({
    required this.id,
    required this.liveClassDays,
    required this.curriculum,
    required this.faqs,
    required this.createdAt,
    required this.modifiedAt,
    required this.instructorId,
    required this.displayImage,
    required this.classTitle,
    required this.summary,
    required this.courseDescription,
    required this.startDate,
    required this.endDate,
    required this.classSize,
    required this.price,
    required this.currency,
    required this.difficultyLevel,
    required this.learningGoals,
    required this.classRequirements,
    required this.benefits,
    required this.assignmentPercentage,
    required this.product,
  });

  factory Bootcamp.fromJson(Map<String, dynamic> json) {
    return Bootcamp(
      id: json['id'] ?? '',
      liveClassDays: List<LiveClassDay>.from((json['live_class_days'] ?? []).map((x) => LiveClassDay.fromJson(x))),
      curriculum: List<Curriculum>.from((json['curriculum'] ?? []).map((x) => Curriculum.fromJson(x))),
      faqs: List<Faq>.from((json['faqs'] ?? []).map((x) => Faq.fromJson(x))),
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      modifiedAt: DateTime.parse(json['modified_at'] ?? ''),
      instructorId: json['instructor_id'] ?? '',
      displayImage: json['display_image'] ?? '',
      classTitle: json['class_title'] ?? '',
      summary: json['summary'] ?? '',
      courseDescription: json['course_description'] ?? '',
      startDate: DateTime.parse(json['start_date'] ?? ''),
      endDate: DateTime.parse(json['end_date'] ?? ''),
      classSize: json['class_size'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
      difficultyLevel: json['difficulty_level'] ?? '',
      learningGoals: List<String>.from((json['learning_goals'] ?? []).map((x) => x)),
      classRequirements: List<String>.from((json['class_requirements'] ?? []).map((x) => x)),
      benefits: List<String>.from((json['benefits'] ?? []).map((x) => x)),
      assignmentPercentage: json['assignment_percentage'] ?? 0,
      product: json['product'] ?? '',
    );
  }
}

class LiveClassDay {
  final String id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final int no;
  final DateTime date;
  final String time;

  LiveClassDay({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.no,
    required this.date,
    required this.time,
  });

  factory LiveClassDay.fromJson(Map<String, dynamic> json) {
    return LiveClassDay(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      modifiedAt: DateTime.parse(json['modified_at'] ?? ''),
      no: json['no'] ?? 0,
      date: DateTime.parse(json['date'] ?? ''),
      time: json['time'] ?? '',
    );
  }
}

class Curriculum {
  final String id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final int no;
  final String topic;
  final String description;

  Curriculum({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.no,
    required this.topic,
    required this.description,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) {
    return Curriculum(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      modifiedAt: DateTime.parse(json['modified_at'] ?? ''),
      no: json['no'] ?? 0,
      topic: json['topic'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Faq {
  final String id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final int no;
  final String question;
  final String answer;

  Faq({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.no,
    required this.question,
    required this.answer,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      modifiedAt: DateTime.parse(json['modified_at'] ?? ''),
      no: json['no'] ?? 0,
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}

class Category {
  final String id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String name;
  final String slug;
  final String type;

  Category({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.name,
    required this.slug,
    required this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      modifiedAt: DateTime.parse(json['modified_at'] ?? ''),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class Tag {
  final String id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String name;
  final String slug;

  Tag({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.name,
    required this.slug,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      modifiedAt: DateTime.parse(json['modified_at'] ?? ''),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

class Seller {
  final String id;
  final String email;
  final String username;
  final String imageUrl;
  final String firstName;
  final String lastName;

  Seller({
    required this.id,
    required this.email,
    required this.username,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      imageUrl: json['image_url'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
    );
  }
}

class Buyer {
  final String id;
  final String email;
  final String username;
  final String imageUrl;
  final String firstName;
  final String lastName;

  Buyer({
    required this.id,
    required this.email,
    required this.username,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) {
    return Buyer(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      imageUrl: json['image_url'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
    );
  }
}

class Instructor {
  final String userId;
  final String email;
  final UserData data;

  Instructor({
    required this.userId,
    required this.email,
    required this.data,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      userId: json['user_id'] ?? '',
      email: json['email'] ?? '',
      data: UserData.fromJson(json['data'] ?? {}),
    );
  }
}

class UserData {
  final String id;
  final String bio;
  final String bank;
  final String email;
  final bool seller;
  final String country;
  final String username;
  final String imageUrl;
  final String lastName;
  final String firstName;
  final String bankAccountName;
  final String bankAccountNumber;

  UserData({
    required this.id,
    required this.bio,
    required this.bank,
    required this.email,
    required this.seller,
    required this.country,
    required this.username,
    required this.imageUrl,
    required this.lastName,
    required this.firstName,
    required this.bankAccountName,
    required this.bankAccountNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      bio: json['bio'] ?? '',
      bank: json['bank'] ?? '',
      email: json['email'] ?? '',
      seller: json['seller'] ?? false,
      country: json['country'] ?? '',
      username: json['username'] ?? '',
      imageUrl: json['image_url'] ?? '',
      lastName: json['last_name'] ?? '',
      firstName: json['first_name'] ?? '',
      bankAccountName: json['bank_account_name'] ?? '',
      bankAccountNumber: json['bank_account_number'] ?? '',
    );
  }
}

void main() {
  // Example usage
  Map<String, dynamic> jsonData = {}; // Your JSON data here
  var purchasedProduct = PurchasedProduct.fromJson(jsonData);
  print(purchasedProduct.id);
}
