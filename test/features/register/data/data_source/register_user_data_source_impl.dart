import 'package:hive/hive.dart';
import '../models/register_model.dart';
import 'register_user_data_source.dart';

class RegisterUserDataSourceImpl implements RegisterUserDataSource {
  @override
  Future<RegisterUserModel> registerUser(
      RegisterUserModel registerUserModel) async {
    try {
      final box = await Hive.openBox('userBox');
      final registerUser = registerUserModel.toJson();
      final key = await box.add(registerUser);
      final Map<String, dynamic> json = await getUser(key, box);

      return RegisterUserModel.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUser(int key, Box<dynamic> box) async {
    final user = await box.get(key);
    box.close();
    return user;
  }
}
