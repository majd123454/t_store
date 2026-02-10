import 'package:get_it/get_it.dart';
import 'package:news_app/app/core/services/supabase/supabase_service.dart';
import 'package:news_app/app/features/auth/data/repositories/login_repo.dart';
import 'package:news_app/app/features/auth/data/repositories/login_repo_impl.dart';
import 'package:news_app/app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:news_app/app/features/auth/auth_features/login/logic/usecases/login_usecase.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ==================== Core ====================
  sl.registerLazySingleton<SupabaseService>(() => SupabaseService.instance);

  // ==================== Auth/Login ====================
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerFactory(() => AuthCubit(sl()));
}
