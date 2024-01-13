import '../models/register_model.dart';

abstract class RegisterUserDataSource {
  Future<String> registerUser(RegisterUserModel registerUserModel);
}
