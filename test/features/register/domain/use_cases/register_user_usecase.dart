import 'package:flutter_test/flutter_test.dart';
import '../repositories/register_user_repository.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';

class RegisterUserUseCase {
  final RegisterUserRepository registerUserRepository;

  RegisterUserUseCase({
    required this.registerUserRepository,
  });

  Future<RegisterUserEntity> call({
    required String email,
    required String password,
    required String name,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      if (!validationEmail(email: email)) {
        throw Exception('Invalid email format');
      }
      if (!validationPassword(password: password)) {
        throw Exception(
            'The password must have at least 8 characters and a number');
      }
      if (!validationName(name: name)) {
        throw Exception('The name must have at least 2 characters');
      }
      
      final RegisterUserEntity registerUserEntity = RegisterUserEntity(
        email: email,
        name: name,
        password: password,
      );

      return await registerUserRepository.registerUser(registerUserEntity);
    }
    return throw Exception('fill in all the fields');
  }

  bool validationEmail({required String email}) {
    RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool validationPassword({required String password}) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  bool validationName({required String name}) {
    return name.length >= 2;
  }
}

void main() {
  setUp(() {});

  group('', () {});
}
