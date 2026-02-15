import 'package:dartz/dartz.dart';
import 'package:news_app/app/features/auth/data/models/user_model.dart';
import 'package:news_app/app/features/auth/data/repositories/auth_repo.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<Either<String, UserEntity>> call({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    return await repository.signUp(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
    );
  }
}
