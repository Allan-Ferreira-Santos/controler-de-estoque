import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/use_cases/register_user_usecase.dart';
import '../../domain/repositories/register_user_repository.dart';
import '../../data/repositories/register_user_repository_impl.dart';



class RegisterModule extends Module {
  @override
  void binds(Injector i) {
    i.add(RegisterUserUseCase.new);
    i.add<RegisterUserRepository>(
      RegisterUserRepositoryImpl.new,
    );
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

void main() {
  Modular.bindModule(RegisterModule());

  late RegisterUserController registerUserController;

  setUp(() {
    print("3");
    registerUserController = RegisterUserController();
  });

  test('should register user successfully', () async {
    const email = 'testexample.com';
    const password = 'password123';
    const name = 'John Doe';

    print("2");

    final result = await registerUserController.registerUser(
      email: email,
      password: password,
      name: name,
    );

    print("5");
    expect(result,
        'expected_result'); // Update this line based on the actual expected result.
  });

  test('should handle registration error', () async {
    const email = 'invalid-email';
    const password = 'password123';
    const name = 'John Doe';

    final result = await registerUserController.registerUser(
      email: email,
      password: password,
      name: name,
    );

    expect(result, isA<String>());
  });
}
