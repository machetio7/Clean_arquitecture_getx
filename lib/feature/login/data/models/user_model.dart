import 'package:paisa_example/feature/login/domain/entitites/user.dart';

class UserModel extends User {
  UserModel({
    // required super.id,
    // required super.name,
    // required super.email,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      // id: json['id'],
      // name: json['name'],
      // email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    // return {'token': token, 'id': id, 'name': name, 'email': email};
    return {'token': token,};
  }

  factory UserModel.fromEntity(UserModel user) {
    return UserModel(
      // id: user.id,
      // name: user.name,
      // email: user.email,
      token: user.token,
    );
  }
}
