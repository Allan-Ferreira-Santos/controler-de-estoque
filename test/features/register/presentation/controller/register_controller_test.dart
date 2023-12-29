import 'dart:io';
import 'package:hive/hive.dart';
import '../../data/models/register_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../data/data_source/register_user_data_source.dart';
import '../../domain/use_cases/register_user_usecase_test.dart';
import '../../domain/repositories/register_user_repository.dart';
import '../../data/data_source/register_user_data_source_impl.dart';
import '../../data/repositories/register_user_repository_impl.dart';

class RegisterModule extends Module {
  @override
  void binds(Injector i) {
    i.add(RegisterUserUseCase.new);
    i.add<RegisterUserRepository>(RegisterUserRepositoryImpl.new);
    i.add<RegisterUserDataSource>(RegisterUserDataSourceImpl.new);
  }
}

class RegisterUserController {
  final registerUserUseCase = Modular.get<RegisterUserUseCase>();

  Future<Object> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final result = await registerUserUseCase.call(
        email: email,
        password: password,
        name: name,
      );

      return result;
    } catch (e) {
      return 'Error when registering $e';
    }
  }
}

void main() async {
  var path = Directory.current.path;
  Hive.init(path);

  Modular.bindModule(RegisterModule());
  late RegisterUserController registerUserController;

  setUp(() {
    registerUserController = RegisterUserController();
  });

  test('should register user successfully', () async {
    const email = 'testALlan123@example.com';
    const password = 'password123';
    const name = 'John Doe';

    final result = await registerUserController.registerUser(
      email: email,
      password: password,
      name: name,
    );

    print(result);

    expect(result, isA<RegisterUserModel>());
  });

  test('should handle registration error', () async {
    const email = 'testeemail.com';
    const password = 'passasd123adadw';
    const name = 'John Doe';

    final result = await registerUserController.registerUser(
      email: email,
      password: password,
      name: name,
    );

    print(result);

    expect(result, isA<Exception>());
  });
}
