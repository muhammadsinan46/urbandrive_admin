import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ud_admin/domain/customers_model.dart';

class InboxRoomRepo {
  Future<List<CustomersModel>> getchatUser() async {
    List<CustomersModel> usersList = [];
   

    final chatcollection =
        await FirebaseFirestore.instance.collection('chat-user').get();

    try {
    for(final element in chatcollection.docs)  {
        final data = element.data();

        final usersCollection = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: data['userId'])
            .get();

        usersCollection.docs.forEach((user) {
          final userdata = user.data();

          final chatuser = CustomersModel(
              id: userdata['uid'],
              name: userdata['name'],
              email: userdata['email']);


          print(chatuser.email);
          usersList.add(chatuser);
        });
      }; 
      return usersList;
    } on FirebaseException catch (e) {
      print("error is ${e.message}");
      return usersList;
    }
  }
}
