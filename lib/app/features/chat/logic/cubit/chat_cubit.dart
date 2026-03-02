import 'dart:async';
import 'package:first_project/app/features/chat/data/models/chat_message_entity.dart';
import 'package:first_project/app/features/chat/data/repository/chat_repository.dart';
import 'package:first_project/app/features/chat/logic/cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;
  StreamSubscription<ChatMessageEntity>? _messagesSubscription;

  ChatCubit({required this.repository}) : super(ChatInitial());

  List<ChatMessageEntity> _messages = [];
  int _currentPage = 0;
  static const int _limit = 50;
  String? _currentOtherUserId;
  DateTime? _latestMessageAt;

  // Expose the currently opened chat other-user id so UI can use it.
  String? get currentOtherUserId => _currentOtherUserId;

  void startListening() {
    _messagesSubscription?.cancel();
    _messagesSubscription = repository.messagesStream.listen((message) {
      if (_currentOtherUserId == null) return;

      if (message.senderId == _currentOtherUserId ||
          message.receiverId == _currentOtherUserId) {
        // Ignore stream items that are older or equal to the latest known message
        if (message.createdAt != null && _latestMessageAt != null) {
          if (!message.createdAt!.isAfter(_latestMessageAt!)) return;
        }

        // append newest at the end (messages: oldest -> newest)
        _messages = [..._messages, message];
        if (message.createdAt != null) {
          _latestMessageAt = message.createdAt;
        }
        emit(ChatLoaded(messages: _messages));
      }
    });
  }

  Future<void> getMessages(String otherUserId, {bool refresh = false}) async {
    _currentOtherUserId = otherUserId;

    if (refresh) {
      _currentPage = 0;
      _messages = [];
    }

    if (_currentPage == 0) {
      emit(ChatLoading());
    }

    final result = await repository.getMessages(
      otherUserId: otherUserId,
      page: _currentPage,
      limit: _limit,
    );

    result.fold(
      (error) => emit(ChatError(error)),
      (messages) {
        // repository returns newest->oldest; convert to oldest->newest for UI
        final incoming = messages.reversed.toList();

        if (_currentPage == 0) {
          _messages = incoming;
        } else {
          // older messages for pagination: prepend them
          _messages = [...incoming, ..._messages];
        }

        // update latest message timestamp
        if (_messages.isNotEmpty) {
          _latestMessageAt = _messages.last.createdAt;
        }
        _currentPage++;
        emit(ChatLoaded(
          messages: _messages,
          hasReachedMax: messages.length < _limit,
        ));
      },
    );
  }

  Future<void> loadMoreMessages(String otherUserId) async {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      if (currentState.hasReachedMax) return;
      await getMessages(otherUserId);
    }
  }

  Future<void> sendMessage({
    required String receiverId,
    required String content,
    MessageType messageType = MessageType.text,
  }) async {
    emit(MessageSending());

    final result = await repository.sendMessage(
      receiverId: receiverId,
      content: content,
      messageType: messageType,
    );

    result.fold(
      (error) => emit(ChatError(error)),
        (message) {
        // append sent message to the end
        _messages = [..._messages, message];
        if (message.createdAt != null) _latestMessageAt = message.createdAt;
        emit(MessageSent(message));
        emit(ChatLoaded(messages: _messages));
      },
    );
  }

  Future<void> markAsRead(String messageId) async {
    await repository.markAsRead(messageId);
  }

  Future<void> markAllAsRead(String senderId) async {
    await repository.markAllAsRead(senderId);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}