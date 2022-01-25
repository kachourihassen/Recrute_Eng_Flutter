import 'package:json_annotation/json_annotation.dart';
part 'userModel.g.dart';

@JsonSerializable()
class UserModel {
  String username;
  String password;
  String email;
  String role;

  UserModel({this.username, this.password, this.email, this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
