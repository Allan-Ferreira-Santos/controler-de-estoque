import 'package:faker/faker.dart';
import '../models/register_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import '../data_source/register_user_data_source.dart';
import '../../domain/repositories/register_user_repository_test.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';

class RegisterUserRepositoryImpl implements RegisterUserRepository {
  final RegisterUserDataSource dataSource;

  RegisterUserRepositoryImpl({required this.dataSource});

  @override
  Future<String> registerUser(RegisterUserEntity registerEntity) async {
    try {
      return await dataSource
          .registerUser(RegisterUserModel.fromEntity(registerEntity));
    } on Exception {
      rethrow;
    }
  }
}

class MockRegisterUserDataSource extends Mock
    implements RegisterUserDataSource {}

void main() {
  RegisterUserModel fakerDataRegister() => RegisterUserModel(
        name: faker.person.name(),
        email: faker.internet.email(),
        password: faker.internet.password(),
      );

  late MockRegisterUserDataSource registerUserDataSource;
  late RegisterUserModel registerUserModel;
  late String fakerId;

  setUp(() => {
        registerUserDataSource = MockRegisterUserDataSource(),
        registerUserModel = fakerDataRegister(),
        fakerId = faker.randomGenerator.string(100),
        registerFallbackValue(registerUserModel)
      });

  group("Deu boa teste repo", () {
    test("sucesso repo", () async {
      when(() => registerUserDataSource.registerUser(any()))
          .thenAnswer((_) async => fakerId);

      final result =
          await registerUserDataSource.registerUser(registerUserModel);

      print(result);

      expect(result, fakerId);
    });
  });
}
