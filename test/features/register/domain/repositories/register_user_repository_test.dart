import 'package:flutter_test/flutter_test.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';

abstract class RegisterUserRepository{

Future<String> registerUser(RegisterUserEntity registerUserEntity); 
}


