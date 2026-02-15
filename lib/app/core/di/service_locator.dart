import 'package:get_it/get_it.dart';
import 'package:news_app/app/core/services/supabase/supabase_service.dart';
import 'package:news_app/app/features/auth/auth_features/signup/logic/signup_usecase.dart';
import 'package:news_app/app/features/auth/data/repositories/auth_repo.dart';
import 'package:news_app/app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:news_app/app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:news_app/app/features/auth/auth_features/login/logic/usecases/login_usecase.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ==================== Core ====================
  sl.registerLazySingleton<SupabaseService>(() => SupabaseService.instance);
  // ==================== Auth ====================
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory(() => AuthCubit(loginUseCase: sl(), signupUseCase: sl()));

  // ==================== Login ====================

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // ==================== SignUp ====================
  sl.registerLazySingleton(() => SignupUseCase(sl()));
}
