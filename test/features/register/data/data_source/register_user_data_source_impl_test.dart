import 'dart:io';
import 'package:hive/hive.dart';
import 'package:faker/faker.dart';
import '../models/register_model.dart';
import 'package:mocktail/mocktail.dart';
import 'register_user_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:controle_de_estoque/features/utils/exceptions/validate_email_exist_exception.dart';


class RegisterUserDataSourceImpl implements RegisterUserDataSource {

  @override
  Future<String> registerUser(RegisterUserModel registerUserModel) async {
    try {
      final box = await Hive.openBox('userBox');

      _validateEmailExists(box, registerUserModel.email);

      final registerUserJson = registerUserModel.toJson();
      final key = await box.add(registerUserJson);
      return key.toString();
    } on Exception {
      rethrow;
    }
  }

  void _validateEmailExists(Box<dynamic> box, String email) {
    final boxValues = box.values;
    for (var value in boxValues) {
      if (value['email'] == email) {
        throw ValidateEmailExistException();
      }
    }
  }
}

class MockHive extends Mock implements HiveInterface {}

class MockRegisterUserDataSource extends Mock
    implements RegisterUserDataSource {}


void main() {
 var path = Directory.current.path;
  Hive.init(path);

  RegisterUserModel fakerDataRegister() => RegisterUserModel(
        name: faker.person.name(),
        email: faker.internet.email(),
        password: faker.internet.password(),
      );

  late RegisterUserModel registerUserModel;
  late MockRegisterUserDataSource mockRegisterUserDataSource;
  late String fakerId;

  setUp(() {
    registerUserModel = fakerDataRegister();
    mockRegisterUserDataSource = MockRegisterUserDataSource();
    fakerId = faker.randomGenerator.string(100);
    registerFallbackValue(registerUserModel);
  });

  group("test DataSource", () {
    test("success", () async {
      
      when(() => mockRegisterUserDataSource.registerUser(any())).thenAnswer((_) async => fakerId);
      
      final result = await mockRegisterUserDataSource.registerUser(registerUserModel);

      print(result);

      expect(result, fakerId);
    });

  });
}
