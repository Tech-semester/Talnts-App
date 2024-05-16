
class RegistrationModel {
  String? username;
  String? firstName;
  String? lastName;
  String? password;

  RegistrationModel({
    this.username,
    this.firstName,
    this.lastName,
    this.password,
});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['password'] = password;

    return data;
  }

}