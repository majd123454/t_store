import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/features/auth/logic/cubit/auth_state.dart';
import 'package:news_app/app/features/auth/auth_features/login/logic/usecases/login_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit(this.loginUseCase) : super(AuthInitial());

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
}
