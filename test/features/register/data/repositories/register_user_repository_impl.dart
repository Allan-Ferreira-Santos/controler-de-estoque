import '../../domain/repositories/register_user_repository.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';

class RegisterUserRepositoryImpl implements RegisterUserRepository{
  @override
  Future<RegisterUserEntity> register(RegisterUserEntity registerEntity) {
    print("PASOO AQUI");
    throw UnimplementedError();
  } 
 

 
}