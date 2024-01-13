import 'package:equatable/equatable.dart';

class RegisterUserEntity extends Equatable{
  final String name;
  final String email;
  final String password;

  const RegisterUserEntity({
    required this.name,
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [
    name,
    email,
    password
  ];
}
