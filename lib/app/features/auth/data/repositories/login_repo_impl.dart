import 'package:dartz/dartz.dart';
import 'package:news_app/app/core/services/supabase/supabase_service.dart';
import 'package:news_app/app/features/auth/data/models/user_model.dart';
import 'package:news_app/app/features/auth/data/repositories/login_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginRepositoryImpl implements LoginRepository {
  final SupabaseService supabase;

  LoginRepositoryImpl(this.supabase);

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
