import 'dart:convert';

class CommunitiesModel {
  String? id;
  String? communityName;
  String? communityDescription;
  String? instructions;
  String? inviteLink;
  String? platform;
  String? status;
  String? creatorId;
  Creator? creator;
  //List<String>? tags;
  // List<Category>? categories;



  CommunitiesModel({
    this.id,
    this.communityName,
    this.communityDescription,
    this.instructions,
    this.inviteLink,
    this.platform,
    this.status,
    this.creatorId,
    this.creator,
   // this.tags,
    // this.categories,

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
      // "categories": categories!.map((category) => category.toMap()).toList(),
      // "tags": tags,
    };
  }


  factory CommunitiesModel.fromMap(Map<String, dynamic> map) {
    return CommunitiesModel(
      id: map['id'],
      communityName: map['name'],
      communityDescription: map['description'],
      instructions: map['instructions'],
      inviteLink: map['inviteLink'],
      platform: map['platform'],
      status: map['status'],
      creatorId: map['creator_id'],
      creator: map['creator'] != null ? Creator.fromMap(map['creator']): null,
      //tags: List<String>.from(map['tags']),
      // categories: List<Category>.from(
      //     map['categories']?.map((category) => Category.fromMap(category))),

    );
  }

  String toJson() => json.encode(toMap());
  factory CommunitiesModel.fromJson(String source) => CommunitiesModel.fromMap(json.decode(source));

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

    // String toJson() => json.encode(toMap());
    //  factory Creator.fromJson(String source) => Creator.fromMap(json.decode(source));

     @override
  String toString(){
      return 'creator(first_name: $firstName, last_name: $lastName, bio: $bio, image_url: $imageUrl)';
     }

}

class Category {
  String? id;
  String? date;
  String? name;
  String? slug;
  String? type;

  Category({
    this.id,
    this.date,
    this.name,
    this.slug,
    this.type,
});

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "created_at": date,
      "name": name,
      "slug": slug,
      "type": type,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map){
    return Category(
      id: map['id'],
      date: map['created_at'],
      name: map['name'],
      slug: map['slug'],
      type: map['type']
    );
  }


}

