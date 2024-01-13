import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import '../repositories/register_user_repository_test.dart';
import 'package:controle_de_estoque/features/utils/exceptions/validate_name_exception.dart';
import 'package:controle_de_estoque/features/utils/exceptions/validate_email_exception.dart';
import 'package:controle_de_estoque/features/utils/exceptions/validate_password_exception.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';
import 'package:controle_de_estoque/features/utils/exceptions/validate_is_not_empty_exception.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_params_entity.dart';

class RegisterUserUseCase {
  final RegisterUserRepository registerUserRepository;

  RegisterUserUseCase({
    required this.registerUserRepository,
  });

  Future<String> call({required RegisterUserParamsEntity params}) async {
    try {
      _validateInputs(
        email: params.email,
        password: params.password,
        name: params.name,
      );

      final RegisterUserEntity userEntity = RegisterUserEntity(
          name: params.name, email: params.email, password: params.password);

      return await registerUserRepository.registerUser(userEntity);
    } on Exception {
      rethrow;
    }
  }

  void _validateInputs({
    required String email,
    required String password,
    required String name,
  }) {
    try {
      _validateFieldsIsNotEmpty(
        email: email,
        password: password,
        name: name,
      );

      _validationEmail(email);

      _validationPassword(password);

      _validationName(name);
    } on Exception {
      rethrow;
    }
  }

  void _validateFieldsIsNotEmpty({
    required String email,
    required String password,
    required String name,
  }) {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw ValidateIsNotEmptyException();
    }
  }

  void _validationEmail(String email) {
    RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      throw ValidateEmailException();
    }
  }

  void _validationPassword(String password) {
    if (password.length < 8 ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]'))) {
      throw ValidatePasswordException();
    }
  }

  void _validationName(String name) {
    if (name.length < 2) {
      throw ValidateNameException();
    }
  }
}

class MockRegisterUserRepository extends Mock
    implements RegisterUserRepository {}

void main() {
  RegisterUserEntity fakerDataRegister() => RegisterUserEntity(
        name: faker.person.name(),
        email: faker.internet.email(),
        password: faker.internet.password(),
      );

  late MockRegisterUserRepository registerUserRepository;
  late RegisterUserEntity registerUserEntity;
  late String fakerId;

  setUp(() => {
        registerUserRepository = MockRegisterUserRepository(),
        registerUserEntity = fakerDataRegister(),
        fakerId = faker.randomGenerator.string(100),
        registerFallbackValue(registerUserEntity)
      });

  group("teste useCase", () {
    test("teste que deu boa", () async {
      when(() => registerUserRepository.registerUser(any()))
          .thenAnswer((_) async => fakerId);

      final result =
          await registerUserRepository.registerUser(registerUserEntity);

      print(result.toString());

      expect(result, fakerId);
    });
  });
}
