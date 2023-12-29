import 'package:hive/hive.dart';
import '../models/register_model.dart';



abstract class RegisterUserDataSource {
  Future<RegisterUserModel> registerUser(RegisterUserModel registerUserModel);

    Future<Map<String, dynamic>> getUser(int key, Box<dynamic> box);

    }
