part of 'chatuser_bloc.dart';

 class ChatuserState extends Equatable {
  const ChatuserState();
  
  @override
  List<Object> get props => [];
}

final class ChatuserInitialState extends ChatuserState {}
final class ChatuserLoadedState extends ChatuserState {

 final  List<CustomersModel> chatusers;
  ChatuserLoadedState({required this.chatusers});


    @override
  List<Object> get props => [chatusers];

}

final class ChatSpecificuserLoadedState extends ChatuserState{

  final List<CustomersModel> chatUsers;
  final String chatuserId;
  final String userName;
  ChatSpecificuserLoadedState({required this.chatUsers, required this.chatuserId, required this.userName});


  List<Object> get props =>[chatUsers, chatuserId,userName];
  

}
