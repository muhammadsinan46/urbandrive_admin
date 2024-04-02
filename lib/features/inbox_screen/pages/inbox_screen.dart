import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:lottie/lottie.dart';
import 'package:ud_admin/domain/customers_model.dart';

import 'package:ud_admin/features/inbox_screen/bloc/chatuser_bloc.dart';
import 'package:ud_admin/features/inbox_screen/domain/inbox_repo.dart';

class InboxScreen extends StatelessWidget {
  InboxScreen({super.key});

  List<dynamic>? usersIdList;
  InboxRoomRepo? chatroom;
  String? prevdate;
  //ChatRoomRepo? chateroom;
List<CustomersModel>? chatUsersList;
String? chatUser;


  var messageController = TextEditingController();

  final DatabaseReference dbref =
      FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    DateTime dateNow = DateTime.now();
    String currentDate =
        "${dateNow.year}-${dateNow.month.toString().padLeft(2, '0')}-${dateNow.day.toString().padLeft(2, "0")}";
    context.read<ChatuserBloc>().add(ChatUserLoadedEvent());
    FirebaseDatabase.instance.ref().child('chat_support').onValue.forEach((user) {
      usersIdList!.add(user);
    });

    return Container(
      height: MediaQuery.sizeOf(context).height - 10,
      width: MediaQuery.sizeOf(context).width - 10,
      child:
          BlocBuilder<ChatuserBloc, ChatuserState>(builder: (context, state) {
        if (state is ChatuserLoadedState) {
             chatUsersList = state.chatusers;
          
          return Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width - 1200,
                  child: ListView.builder(
                    itemCount: state.chatusers.length,
                    itemBuilder: (context, index) {

                      chatUser = state.chatusers[index].name;
                      return Card(
                        child: ListTile(
                          onTap: () {
                            context.read<ChatuserBloc>().add(
                                ChatSpecificUserEvent(
                                  userName: state.chatusers[index].name,
                                    userId: state.chatusers[index].id));
                          },
                          tileColor: const Color.fromARGB(255, 240, 248, 255),
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text("${state.chatusers[index].name}"),
                        ),
                      );
                    },
                  )),
                  SizedBox(width: 20,),
              Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(30)),
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width - 700,

                child: Center(child: Lottie.asset('lib/assets/images/chatgif.json'),),
              )
            ],
          );
        } else if (state is ChatSpecificuserLoadedState) {

      
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                 
                        borderRadius: BorderRadius.circular(30)),
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width - 1200,
                    child: ListView.builder(
                      itemCount: state.chatUsers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {

                                context.read<ChatuserBloc>().add(
                                ChatSpecificUserEvent(
                                  userName:chatUsersList![index].name,
                                    userId:chatUsersList![index].id));
                            },
                            tileColor: const Color.fromARGB(255, 240, 248, 255),
                            leading: CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text("${state.chatUsers[index].name}"),
                          ),
                        );
                      },
                    )),
                     SizedBox(width: 20,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue,),borderRadius: BorderRadius.circular(30)),
                  height: MediaQuery.sizeOf(context).height - 10,
                  width: MediaQuery.sizeOf(context).width - 700,
                  child: Column(
                    children: [
                      Container(   
                        child: ListTile(leading: CircleAvatar(child: Icon(Icons.person),),title:  Text("${state.userName}", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),),),
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),      color: Colors.blue,),
                  
                         height: 60,
                  width: MediaQuery.sizeOf(context).width - 700,

                  ),
                      Container(
                        height: MediaQuery.sizeOf(context).height-215,
                        width: MediaQuery.sizeOf(context).width - 700,
                        child: StreamBuilder(
                          stream: dbref.child( state.chatuserId).onValue,
                          builder:
                              (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data!.snapshot.value != null) {
                              Map<dynamic, dynamic> map = snapshot
                                  .data!.snapshot.value as Map<dynamic, dynamic>;
                              List<dynamic> message = map.values.toList();
            
                              message.forEach((chat) {
                                if (chat['datetime'] is String) {
                                  chat['datetime'] =
                                      DateTime.parse(chat['datetime']);
                                }
                              });
            
                              message.sort(
                                (a, b) => b['datetime'].compareTo(a['datetime']),
                              );
                              message = message.reversed.toList();
            
                              return ListView.builder(
                                itemCount:
                                    snapshot.data!.snapshot.children.length,
                                itemBuilder: (context, index) {

                                  chatUser = state.chatuserId;
                                  String messageDate = message[index]['datetime']
                                      .toString()
                                      .substring(0, 10);
                                  bool isDisplayed = true;
            
                                  if (prevdate == null &&
                                      messageDate != prevdate) {
                                    isDisplayed = true;
                                    prevdate = messageDate;
                                  }
                                  return Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (isDisplayed)
                                      DateChip(date: DateTime.parse(     messageDate == currentDate
                                                ? currentDate
                                                : messageDate.substring(0, 10),)),
                                        // Center(
                                        //   child: Text(
                                       
                                        //     style: TextStyle(color: Colors.grey),
                                        //   ),
                                        // ),
                                      getmessages(context, message, index, state.chatuserId)
                                    ],
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            }
            
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(5),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: TextField(
                              maxLines: 1,
                              controller: messageController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: "Type a message"),
                            )),
                            IconButton(
                                onPressed: () {
                                  Map<String, dynamic> data = {
                                    "senderId": "admin@gmail.com",
                                    "message": messageController.text.trim(),
                                    "datetime": DateTime.now().toIso8601String()
                                  };
                                  _sendMessage(context, data);
            
                                  
                                },
                                icon: Icon(Icons.send))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Container();
      }),
    );
  }

  getmessages(BuildContext context, List message, int index, String userId) {
    bool isSender =
        message[index]['senderId'] == "admin@gmail.com" ? true : false;
    return ChatBubble(
      alignment: isSender?Alignment.bottomRight:Alignment.bottomLeft,
      backGroundColor:  isSender?Colors.green:Colors.blue,
      clipper: ChatBubbleClipper4(type: isSender ?BubbleType.sendBubble:BubbleType.receiverBubble),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width-200
        ),
        child: Text('${message[index]['message']}',style: TextStyle(color: Colors.white),)),
    );
  
  }

  void _sendMessage(BuildContext context, Map<String, dynamic> data) {
    dbref.child(chatUser!).push().set(data).whenComplete(() => messageController.clear());
  }
}
