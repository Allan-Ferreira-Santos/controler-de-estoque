import '../models/register_model.dart';


abstract class RegisterUserDataSource {
  Future<RegisterUserModel> registerUser(RegisterUserModel registerUserModel);
}
