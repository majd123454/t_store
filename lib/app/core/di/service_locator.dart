import 'package:dio/dio.dart';
import 'package:first_project/app/core/services/network/dio_client.dart';
import 'package:first_project/app/features/chat/data/repository/chat_repository.dart';
import 'package:first_project/app/features/chat/data/repository/chat_repository_impl.dart';
import 'package:first_project/app/features/chat/logic/cubit/chat_cubit.dart';
import 'package:first_project/app/features/home/data/data_source_remote/product_remote_data_source.dart';
import 'package:first_project/app/features/home/data/repositories/product_repository.dart';
import 'package:first_project/app/features/home/data/repositories/product_repository_impl.dart';
import 'package:first_project/app/features/home/logic/cubit/product_cubit.dart';
import 'package:first_project/app/features/home/logic/use_cases/get_products_list_usecase.dart';
import 'package:first_project/app/features/navigation_bar/logic/cubit/navigation_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/auth_features/login/logic/usecases/login_usecase.dart';
import '../../features/auth/auth_features/signup/logic/signup_usecase.dart';
import '../../features/auth/data/repositories/auth_repo.dart';
import '../../features/auth/data/repositories/auth_repo_impl.dart';
import '../../features/auth/logic/cubit/auth_cubit.dart';
import '../services/supabase/supabase_service.dart';

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
  // ==================== Bottom Navigation Bar ====================
  sl.registerFactory(() => NavigationCubit());

    // Services
  sl.registerSingleton<DioClient>(DioClient());
  // DataSources
  sl.registerSingleton<ProductRemoteDataSource>(ProductRemoteDataSourceImpl(dio: sl()));

    // ==================== Products ====================

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl( remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProductsListUsecase( productRepository: sl()));
  
  // Cubit
  sl.registerFactory(
    () => ProductCubit( getProductsListUsecase: sl(),
    ),
  );


// ==================== Chat ====================
  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(supabaseService: sl()),
  );

  // Cubit
  sl.registerFactory(() => ChatCubit(repository: sl()));

}
