import 'package:dartz/dartz.dart';
import 'package:paisa_example/core/error/failure.dart';
import 'package:paisa_example/feature/login/domain/entitites/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
