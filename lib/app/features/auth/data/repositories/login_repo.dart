import 'package:dartz/dartz.dart';
import 'package:news_app/app/features/auth/data/models/user_model.dart';

abstract class LoginRepository {
  Future<Either<String, UserEntity>> signIn({
    required String email,
    required String password,
  });
}
