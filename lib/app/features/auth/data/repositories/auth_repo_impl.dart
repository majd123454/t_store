import 'package:dartz/dartz.dart';
import 'package:first_project/app/features/auth/data/repositories/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/supabase/supabase_service.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseService supabase;

  AuthRepositoryImpl(this.supabase);

  @override
  Future<Either<String, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.signIn(email: email, password: password);

      if (response.user == null) {
        return const Left('فشل تسجيل الدخول');
      }

      return Right(
        UserEntity(id: response.user!.id, email: response.user!.email ?? email),
      );
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e.message));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    try {
      final response = await supabase.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName, 'phone': phone},
      );

      if (response.user == null) {
        return const Left('فشل إنشاء الحساب');
      }

      return Right(
        UserEntity(
          id: response.user!.id,
          email: email,
          fullName: fullName,
          phone: phone,
        ),
      );
    } on AuthException catch (e) {
      return Left(_getAuthErrorMessage(e.message));
    } catch (e) {
      return Left(e.toString());
    }
  }

  String _getAuthErrorMessage(String message) {
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('invalid login credentials')) {
      return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
    }
    if (lowerMessage.contains('email not confirmed')) {
      return 'يرجى تأكيد بريدك الإلكتروني أولاً';
    }
    if (lowerMessage.contains('user already registered')) {
      return 'هذا البريد الإلكتروني مسجل بالفعل';
    }
    if (lowerMessage.contains('password')) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    if (lowerMessage.contains('email')) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    if (lowerMessage.contains('rate limit')) {
      return 'تم تجاوز عدد المحاولات المسموحة. يرجى المحاولة لاحقاً';
    }

    return message;
  }
}
