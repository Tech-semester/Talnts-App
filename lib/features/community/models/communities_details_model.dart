import 'dart:convert';

class CommunitiesDetailsModel {
  String? message;
  Data? data;

  CommunitiesDetailsModel({
   this.message,
    this.data,
});

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "data": data!.toString(),
    };
  }

  factory CommunitiesDetailsModel.fromMap(Map<String, dynamic> map) {
    return CommunitiesDetailsModel(
      message: map['message'],
      data: map['data']!= null ? Data.fromMap(map['data']): null
    );
  }

  String toJson() => json.encode(toMap());
  factory CommunitiesDetailsModel.fromJson(String source) => CommunitiesDetailsModel.fromMap(json.decode(source));

}
class Data {
  String? id;
  String? communityName;
  String? communityDescription;
  String? instructions;
  String? inviteLink;
  String? platform;
  String? status;
  String? creatorId;
  Creator? creator;

  Data({
    this.id,
    this.communityName,
    this.communityDescription,
    this.instructions,
    this.inviteLink,
    this.platform,
    this.status,
    this.creatorId,
    this.creator,
});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": communityName,
      "description": communityDescription,
      "instructions": instructions,
      "inviteLink": inviteLink,
      "platform": platform,
      "status": status,
      "creator_id": creatorId,
      "creator": creator!.toString(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'],
      communityName: map['name'],
      communityDescription: map['description'],
      instructions: map['instructions'],
      inviteLink: map['inviteLink'],
      platform: map['platform'],
      status: map['status'],
      creatorId: map['creator_id'],
      creator: map['creator'] != null ? Creator.fromMap(map['creator']): null,

    );
  }
}

class Creator {
  String? id;
  String? bio;
  String? imageUrl;
  String? firstName;
  String? lastName;

  Creator({
    this.id,
    this.bio,
    this.imageUrl,
    this.firstName,
    this.lastName,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "bio": bio,
      "image_url": imageUrl,
      "first_name": firstName,
      "last_name": lastName,
    };
  }

  factory Creator.fromMap(Map<String, dynamic> map) {
    return Creator(
      id: map['id'],
      bio: map['bio'],
      imageUrl: map['image_url'],
      firstName: map['first_name'],
      lastName: map['last_name'],
    );
  }

  String get fullName => "$firstName $lastName";
  @override
  String toString(){
    return 'creator(first_name: $firstName, last_name: $lastName, bio: $bio, image_url: $imageUrl)';
  }

}