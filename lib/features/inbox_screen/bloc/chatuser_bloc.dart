import 'dart:async';
import 'dart:js_interop';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/domain/customers_model.dart';
import 'package:ud_admin/features/inbox_screen/data/chat_model.dart';
import 'package:ud_admin/features/inbox_screen/domain/inbox_repo.dart';

part 'chatuser_event.dart';
part 'chatuser_state.dart';

class ChatuserBloc extends Bloc<ChatuserEvent, ChatuserState> {
    InboxRoomRepo inboxroom;
  ChatuserBloc(this.inboxroom) : super(ChatuserState()) {
  

  on<ChatUserLoadedEvent>(chatuserLoading);
  on<ChatSpecificUserEvent>(onChatSpecificUser);
  }

  FutureOr<void> chatuserLoading(ChatUserLoadedEvent event, Emitter<ChatuserState> emit) async{

try{

      final chatusersList = await inboxroom.getchatUser();

      print("in bloc ${chatusersList}");

    emit(ChatuserLoadedState(chatusers: chatusersList));
}catch (e){

  print("${e.toString()}");
}
  }

  FutureOr<void> onChatSpecificUser(ChatSpecificUserEvent event, Emitter<ChatuserState> emit)async {

    final chatusersList = await inboxroom.getchatUser();

    emit(ChatSpecificuserLoadedState(chatUsers: chatusersList, chatuserId: event.userId, userName: event.userName));
  }
}
