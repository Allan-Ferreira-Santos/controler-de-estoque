import 'dart:io';
import 'package:hive/hive.dart';
import '../../data/models/register_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../repositories/register_user_repository.dart';
import '../../data/data_source/register_user_data_source.dart';
import '../../data/data_source/register_user_data_source_impl.dart';
import '../../data/repositories/register_user_repository_impl.dart';
import '../../presentation/controller/register_controller_test.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';

class RegisterUserUseCase {
  final RegisterUserRepository registerUserRepository;

  RegisterUserUseCase({
    required this.registerUserRepository,
  });

  Future<Object> call({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return Exception('Fill in all the fields');
      }

      if (!validationEmail(email: email)) {
        return Exception('Invalid email format');
      }

      if (!validationPassword(password: password)) {
        return Exception(
            'The password must have at least 8 characters and a number');
      }

      if (!validationName(name: name)) {
        return Exception('The name must have at least 2 characters');
      }

      final RegisterUserEntity registerUserEntity = RegisterUserEntity(
        email: email,
        name: name,
        password: password,
      );

      return await registerUserRepository.registerUser(registerUserEntity);
    } catch (e) {
      return Exception('Error when registering: $e');
    }
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
  var path = Directory.current.path;
  Hive.init(path);

  Modular.bindModule(RegisterModule());

  late RegisterUserUseCase registerUserUseCase;
  late RegisterUserRepository registerUserRepository;
  late RegisterUserDataSource registerUserDataSource;

  setUp(() {
    registerUserDataSource = RegisterUserDataSourceImpl();
    registerUserRepository =
        RegisterUserRepositoryImpl(dataSource: registerUserDataSource);
    registerUserUseCase =
        RegisterUserUseCase(registerUserRepository: registerUserRepository);
  });

  test('should register user successfully', () async {
    const email = 'testeaAllan@example.com';
    const password = 'password123';
    const name = 'John Doe';

    final result = await registerUserUseCase.call(
        email: email, password: password, name: name);

    print(result);

    expect(result, isA<RegisterUserModel>());
  });

  test('should return error message for empty values', () async {
    const email = '';
    const password = '';
    const name = '';

    final result = await registerUserUseCase.call(
        email: email, password: password, name: name);

    print(result);

    expect(result, isA<Exception>());
  });

  test('should return error message for invalid email', () async {
    const email = 'allaasnteste.com';
    const password = 'all45678';
    const name = 'allan';

    final result = await registerUserUseCase.call(
        email: email, password: password, name: name);

    print(result);

    expect(result, isA<Exception>());
  });

  test('should return error message for invalid password', () async {
    const email = 'allaasnasd@adteste.com';
    const password = 'all78';
    const name = 'allan';

    final result = await registerUserUseCase.call(
        email: email, password: password, name: name);

    print(result);

    expect(result, isA<Exception>());
  });

  test('should return error message for invalid name', () async {
    const email = 'allantedssaf@asfgasste.com';
    const password = 'all45678';
    const name = 'a';

    final result = await registerUserUseCase.call(
        email: email, password: password, name: name);

    print(result);

    expect(result, isA<Exception>());
  });
}
