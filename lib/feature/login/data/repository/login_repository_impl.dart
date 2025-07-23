import 'package:dartz/dartz.dart';
import 'package:paisa_example/core/error/failure.dart';
import 'package:paisa_example/feature/login/data/datasource/login_remote_data_source.dart';
import 'package:paisa_example/feature/login/domain/entitites/user.dart';
import 'package:paisa_example/feature/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository { 
  final LoginRemoteDataSource loginRemoteDataSourceImpl;

  LoginRepositoryImpl({required this.loginRemoteDataSourceImpl});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await loginRemoteDataSourceImpl.login(email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('Error login'));
    }
  }
}
