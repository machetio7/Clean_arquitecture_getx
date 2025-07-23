import 'package:dartz/dartz.dart';
import 'package:paisa_example/core/error/failure.dart';
import 'package:paisa_example/feature/login/domain/entitites/user.dart';
import 'package:paisa_example/feature/login/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<Either<Failure, User>> call(String email, String password) async {
    return await loginRepository.login(email, password);
  }
}
