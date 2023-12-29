import 'package:hive/hive.dart';
import '../models/register_model.dart';
import 'register_user_data_source.dart';

class RegisterUserDataSourceImpl implements RegisterUserDataSource {
  @override
  Future<RegisterUserModel> registerUser(
      RegisterUserModel registerUserModel) async {
    try {
      final box = await Hive.openBox('userBox');

      if (!_validateEmailExists(box, registerUserModel.email)) {
        final registerUserJson = registerUserModel.toJson();
        final key = await box.add(registerUserJson);
        final userJson = await getUser(key, box);

        return RegisterUserModel.fromJson(userJson);
      }

      throw Exception('Email already exists');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getUser(int key, Box<dynamic> box) async {
    try {
      final user = await box.get(key);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  bool _validateEmailExists(Box<dynamic> box, String email) {
    final boxValues = box.values;
    for (var value in boxValues) {
      if (value['email'] == email) {
        return true;
      }
    }
    return false;
  }
}
