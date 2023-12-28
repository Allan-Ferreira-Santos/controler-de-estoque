import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';

class RegisterUserModel extends RegisterUserEntity {
  RegisterUserModel({
      required super.name,
      required super.email,
      required super.password});

  factory RegisterUserModel.fromEntity(RegisterUserEntity registerUserEntity) =>
      RegisterUserModel(
        name: registerUserEntity.name,
        email: registerUserEntity.email,
        password: registerUserEntity.password,
      );

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
