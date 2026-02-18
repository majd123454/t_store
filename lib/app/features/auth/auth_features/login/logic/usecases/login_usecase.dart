import 'package:dartz/dartz.dart';

import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/auth_repo.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, UserEntity>> call(String email, String password) async {
    return await repository.signIn(email: email, password: password);
  }
}
