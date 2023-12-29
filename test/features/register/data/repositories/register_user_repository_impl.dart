import '../models/register_model.dart';
import '../data_source/register_user_data_source.dart';
import '../../domain/repositories/register_user_repository.dart';
import 'package:controle_de_estoque/features/register/domain/entities/register_user_entity.dart';

class RegisterUserRepositoryImpl implements RegisterUserRepository {
  final RegisterUserDataSource dataSource;

  RegisterUserRepositoryImpl({required this.dataSource});

  @override
  Future<RegisterUserEntity> registerUser(
      RegisterUserEntity registerEntity) async {
    return await dataSource
        .registerUser(RegisterUserModel.fromEntity(registerEntity));
  }
}
