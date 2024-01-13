import 'package:equatable/equatable.dart';

class RegisterUserParamsEntity extends Equatable {
  final String name;
  final String email;
  final String password;

  const RegisterUserParamsEntity(
      {required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}
