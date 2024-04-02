part of 'booking_data_bloc.dart';

 class BookingDataEvent extends Equatable {
  const BookingDataEvent();

  @override
  List<Object> get props => [];
}
class BookingDataLoadingEvent extends BookingDataEvent{}
class BookingDataLoadedEvent extends  BookingDataEvent{}
class UpcomingBookingEvent extends  BookingDataEvent{}

