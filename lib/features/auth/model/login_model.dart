import 'dart:convert';

LoginModel? loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel? data) => json.encode(data!.toJson());

class LoginModel {
  String? accessToken;
  String? refreshToken;
  bool? message;
  User? user;

  LoginModel({
    this.accessToken,
    this.refreshToken,
    this.message,
    this.user,
  });

  factory LoginModel.fromJson(Map<dynamic, dynamic> json) => LoginModel(
        accessToken: json["access"],
        refreshToken: json["refresh"],
        message: json["status"],
        user: User.fromJson(json["user"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "user": user!.toJson(),
        "access": accessToken,
        "refresh": refreshToken,
        "status": message,
      };
}

class User {
  String? userId;
  String? email;
  String? imageUrl;
  bool? registrationStatus;

  User({
    this.userId,
    this.email,
    this.imageUrl,
    this.registrationStatus,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
        userId: json["user_id"],
        email: json["email"],
        imageUrl: json["image_url"],
        registrationStatus: json["registration_complete"],
      );

  Map<dynamic, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "image_url": imageUrl,
        "registration_complete": registrationStatus
      };
}
