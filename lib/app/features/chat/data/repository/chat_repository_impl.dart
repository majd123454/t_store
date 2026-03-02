import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:first_project/app/core/services/supabase/supabase_service.dart';
import 'package:first_project/app/core/services/supabase/supabase_table.dart';
import 'package:first_project/app/features/chat/data/models/chat_message_entity.dart';
import 'package:first_project/app/features/chat/data/models/chat_message_model.dart';
import 'package:first_project/app/features/chat/data/repository/chat_repository.dart';
class ChatRepositoryImpl implements ChatRepository {
  final SupabaseService supabaseService;
  StreamController<ChatMessageEntity>? _messagesController;

  ChatRepositoryImpl({required this.supabaseService});

  String get _userId => supabaseService.currentUser?.id ?? '';

  @override
  Future<Either<String, List<ChatMessageEntity>>> getMessages({
    required String otherUserId,
    int page = 0,
    int limit = 50,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final from = page * limit;
      final to = from + limit - 1;

      // Fetch messages first (without relying on foreign-key relationships)
      final response = await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .select()
          .or('and(sender_id.eq.$_userId,receiver_id.eq.$otherUserId),and(sender_id.eq.$otherUserId,receiver_id.eq.$_userId)')
          .order('created_at', ascending: false)
          .range(from, to);

        final rows = (response as List).cast<Map<String, dynamic>>();

        // Collect unique sender ids to fetch their profiles in one request
        final senderIds = rows
          .map((r) => r['sender_id'] as String?)
          .whereType<String>()
          .toSet()
          .toList();

      Map<String, Map<String, dynamic>> profilesMap = {};
      if (senderIds.isNotEmpty) {
        // Fetch profiles individually to avoid relying on client method signatures
        for (final sid in senderIds) {
          try {
            final profilesResp = await supabaseService.client
                .from(SupabaseTables.profiles)
                .select('id, full_name, avatar_url')
                .eq('id', sid)
                .single();

            final m = profilesResp;
            profilesMap[m['id'] as String] = m;
          } catch (_) {}
        }
      }

      // Merge sender profile into each message map under 'sender' key to match model expectation
      final messages = rows.map((json) {
        final Map<String, dynamic> copy = Map<String, dynamic>.from(json);
        final sid = copy['sender_id'] as String?;
        if (sid != null && profilesMap.containsKey(sid)) {
          copy['sender'] = {
            'full_name': profilesMap[sid]!['full_name'],
            'avatar_url': profilesMap[sid]!['avatar_url'],
          };
        }
        return ChatMessageModel.fromJson(copy);
      }).toList();

      return Right(messages);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ChatMessageEntity>> sendMessage({
    required String receiverId,
    required String content,
    MessageType messageType = MessageType.text,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final response = await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .insert({
            'sender_id': _userId,
            'receiver_id': receiverId,
            'content': content,
            'message_type': messageType.name,
          })
          .select()
          .single();

      final row = response;

      // Try to fetch sender profile and merge
      try {
        final profileResp = await supabaseService.client
            .from(SupabaseTables.profiles)
            .select('full_name, avatar_url')
            .eq('id', _userId)
            .single();

        final profile = profileResp;
        row['sender'] = {
          'full_name': profile['full_name'],
          'avatar_url': profile['avatar_url'],
        };
      } catch (_) {}

      return Right(ChatMessageModel.fromJson(row));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> markAsRead(String messageId) async {
    try {
      await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .update({'is_read': true})
          .eq('id', messageId)
          .eq('receiver_id', _userId);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> markAllAsRead(String senderId) async {
    try {
      await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .update({'is_read': true})
          .eq('sender_id', senderId)
          .eq('receiver_id', _userId)
          .eq('is_read', false);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<ChatMessageEntity> get messagesStream {
    if (_userId.isEmpty) {
      return Stream.empty();
    }

    _messagesController?.close();
    _messagesController = StreamController<ChatMessageEntity>.broadcast();

    supabaseService.client
        .from(SupabaseTables.chatMessages)
        .stream(primaryKey: ['id'])
        .eq('receiver_id', _userId)
        .listen((data) async {
          for (final item in data) {
            try {
              final row = item;
              // fetch sender profile
              try {
                final profileResp = await supabaseService.client
                    .from(SupabaseTables.profiles)
                    .select('full_name, avatar_url')
                    .eq('id', row['sender_id'])
                    .single();

                final profile = profileResp;
                row['sender'] = {
                  'full_name': profile['full_name'],
                  'avatar_url': profile['avatar_url'],
                };
              } catch (_) {}

              _messagesController?.add(ChatMessageModel.fromJson(row));
            } catch (_) {}
          }
        });

    return _messagesController!.stream;
  }

  @override
  Future<Either<String, int>> getUnreadCount() async {
    try {
      if (_userId.isEmpty) {
        return const Right(0);
      }

      final response = await supabaseService.client
          .from(SupabaseTables.chatMessages)
          .select('id')
          .eq('receiver_id', _userId)
          .eq('is_read', false);

      return Right((response as List).length);
    } catch (e) {
      return Left(e.toString());
    }
  }
}