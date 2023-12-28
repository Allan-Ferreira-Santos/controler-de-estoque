import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';

abstract class RegisterUserRepository{

Future<RegisterUserEntity> registerUser(RegisterUserEntity registerUserEntity); 
}