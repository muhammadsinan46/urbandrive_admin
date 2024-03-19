import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/domain/booking_model.dart';


class BookingRepo {
  Future<List<BookingModel>> getBookingData() async {
  List<BookingModel> bookingDataList = [];
    try {

        
      final collection =
          await FirebaseFirestore.instance.collection('bookings').get();

      collection.docs.forEach((element)async {
        final data = element.data();

        

        final bookingdata =BookingModel(
              agrchcked: data['checked'],
              userId: data['uid'],
              CarmodelId: data['carmodel-id'],
              BookingId: data['booking-id'],
              BookingDays: data['booking-days'],
              PickupDate: data['pickup-date'],
              PickupTime: data['pick-up time'],
              PickupAddress: data['pickup-address'],
              DropOffDate: data['dropoff-date'],
              DropOffTime: data['drop-off time'],
              DropoffAddress: data['dropoff-location'],
              PaymentAmount: data['toal-pay'].toString(),
              PaymentStatus: data['payment-status'],
              carmodel: data['carmodel'],
              userdata: data['userdata']);
        bookingDataList.add(bookingdata);
      });
      print("booking data is ${bookingDataList[0]}");
      return bookingDataList;
    } on FirebaseException catch (e) {
      print("error occure geeting booking data ${e.message}");
      return bookingDataList;
    }
  }
}
