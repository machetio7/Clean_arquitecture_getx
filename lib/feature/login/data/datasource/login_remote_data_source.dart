import 'package:dio/dio.dart';
import 'package:paisa_example/core/network/api_endpoints.dart';
import 'package:paisa_example/feature/login/data/models/user_model.dart';
import 'package:paisa_example/feature/login/domain/entitites/user.dart';

abstract class LoginRemoteDataSource {
  Future<User> login(String email, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio dio;

   LoginRemoteDataSourceImpl({required this.dio}); 

  @override
  Future<User> login(String email, String password) async {
    final response = await dio.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }
}
