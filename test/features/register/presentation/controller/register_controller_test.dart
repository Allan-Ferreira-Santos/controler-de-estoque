import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/use_cases/register_user_usecase_test.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_params_entity.dart';

class RegisterUserController {
  final registerUserUseCase = Modular.get<RegisterUserUseCase>();

  Future<Object> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final RegisterUserParamsEntity entityParams = RegisterUserParamsEntity(
        name: name,
        email: email,
        password: password,
      );

      final result = await registerUserUseCase.call(params: entityParams);

      return result;
    } catch (e) {
      return e;
    }
  }
}

class MockRegisterUserUseCase extends Mock implements RegisterUserUseCase {}

void main() async {
  RegisterUserParamsEntity fakerDataRegister() => RegisterUserParamsEntity(
        name: faker.person.name(),
        email: faker.internet.email(),
        password: faker.internet.password(),
      );

  late RegisterUserUseCase registerUserUseCase;
  late RegisterUserParamsEntity registerUserParams;
  late String fakerId;

  setUp(() {
    registerUserUseCase = MockRegisterUserUseCase();
    registerUserParams = fakerDataRegister();
    fakerId = faker.randomGenerator.string(100);
    registerFallbackValue(registerUserParams);
  });

  group("Register user", () {
    test('should register user successfully', () async {
      when(() => registerUserUseCase.call(params: any(named: 'params')))
          .thenAnswer((_) async => fakerId);

      final result = await registerUserUseCase.call(params: registerUserParams);

      print(result);

      expect(result, fakerId);

      verify(() => registerUserUseCase.call(params: registerUserParams))
          .called(1);
    });
  });
}
