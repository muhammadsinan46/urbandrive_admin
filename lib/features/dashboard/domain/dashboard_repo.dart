import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ud_admin/features/dashboard/data/dash_card_model.dart';

class DashBoardRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<DashCardModel> getCardDetails() async {
    DashCardModel dashcard;

    final usersDoc =
        await firestore.collection('users').get();
    final carsDoc =
        await firestore.collection('fleets').get();
    final bookingDoc =
        await firestore.collection('bookings').get();
    final collection = await firestore.collection('bookings').get();

    int revenue = 0;
    collection.docs.forEach((element) {
      final int data = int.parse(element.get('toal-pay'));

      revenue += data;
    });
  
dashcard = DashCardModel(
   
        totalBooking: bookingDoc.docs.length,
        totalCars: carsDoc.docs.length,
        totalCustomers: usersDoc.docs.length,
        totalRevenue: revenue);



    return dashcard;
  }
}
