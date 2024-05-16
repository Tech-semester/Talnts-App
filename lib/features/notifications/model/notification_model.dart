import 'dart:convert';

class NotificationModel {
  String? notificationId;
  bool? viewed;
  String? dateCreated;
  String? title;
  String? message;
  String? imageUrl;


  NotificationModel({
    this.notificationId,
    this.viewed,
    this.dateCreated,
    this.title,
    this.message,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if(notificationId != null){
      result.addAll({'id': notificationId});
    }
    if(viewed != null){
      result.addAll({'viewed': viewed});
    }
    if(dateCreated != null){
      result.addAll({'created_at': dateCreated});
    }
    if(title != null){
      result.addAll({'title': title});
    }
    if(message != null){
      result.addAll({'message': message});
    }
    if(imageUrl != null){
      result.addAll({'image_url': imageUrl});
    }

    return result;
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      notificationId: map['id'],
      viewed: map['viewed'],
      dateCreated: map['created_at'],
      title: map['title'],
      message: map['message'],
      imageUrl: map['image_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(id: $notificationId, viewed: $viewed, created_at: $dateCreated, title: $title, message: $message, image_url: $imageUrl)';
  }
}
