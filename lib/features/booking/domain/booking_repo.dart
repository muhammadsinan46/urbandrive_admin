import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/features/booking/data_model/booking_model.dart';

class BookingRepo {
  final bookingDb = FirebaseFirestore.instance.collection('bookings');

  Future<List<BookingModel>> getBookingData() async {
    List<BookingModel> bookingDataList = [];
    try {
      final snapshot = await bookingDb.get();

      snapshot.docs.forEach((element) async {
        final data = element.data();

        final bookingdata = BookingModel(
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

  Future<  List<BookingModel>> getUpcomingBooking() async {
    List<BookingModel> upcomingbookList = [];

    final snapshot = await bookingDb.orderBy('pickup-date').get();


    DateTime pickupDate;
    DateTime currentDate = DateTime.now();
    snapshot.docs.forEach((element) async {
      final bookingDate = element['pickup-date'];

      pickupDate = DateTime.parse(bookingDate);

   

      if (pickupDate.isAfter(currentDate)) {
        final data = element.data();
      //  print("booking length is ${data.length}");

        final bookingdata = BookingModel(
           
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

       
        upcomingbookList.add(bookingdata);
      }
    });
    return upcomingbookList;
  }
}
