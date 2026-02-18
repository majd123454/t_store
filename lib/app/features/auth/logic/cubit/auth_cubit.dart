import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth_features/login/logic/usecases/login_usecase.dart';
import '../../auth_features/signup/logic/signup_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthCubit({required this.loginUseCase, required this.signupUseCase})
    : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());

    final result = await loginUseCase(email, password);

    result.fold((error) {
      if (error.contains('تأكيد بريدك')) {
        emit(AuthEmailConfirmationRequired(email));
      } else {
        emit(AuthError(error));
      }
    }, (user) => emit(AuthAuthenticated(user)));
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    emit(AuthLoading());

    final result = await signupUseCase(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
    );
    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthEmailConfirmationRequired(email)),
    );
  }
}
