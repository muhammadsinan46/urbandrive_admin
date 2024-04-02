part of 'booking_data_bloc.dart';

 class BookingDataState extends Equatable {
  const BookingDataState();
  
  @override
  List<Object> get props => [];
}

final class BookingDataInitialState extends BookingDataState {
    List<Object> get props =>[];
}
final class BookingDataLoadedState extends BookingDataState {

  final List<BookingModel> bookingdataList;

  BookingDataLoadedState({required this.bookingdataList});

  List<Object> get props =>[bookingdataList];




}

final class UpcomingBookingState extends BookingDataState {

  final List<BookingModel> upcomingBookingList;

  UpcomingBookingState({required this.upcomingBookingList});

  List<Object> get props =>[upcomingBookingList];




}
