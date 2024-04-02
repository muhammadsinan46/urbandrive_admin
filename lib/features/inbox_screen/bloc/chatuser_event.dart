part of 'chatuser_bloc.dart';

sealed class ChatuserEvent extends Equatable {
  const ChatuserEvent();

  @override
  List<Object> get props => [];
}


class ChatUserLoadedEvent extends ChatuserEvent{}
class ChatSpecificUserEvent extends ChatuserEvent{
  final String userId;
  final String userName;
  ChatSpecificUserEvent({required this.userId, required this.userName});
  
}