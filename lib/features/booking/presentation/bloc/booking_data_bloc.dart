import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/features/booking/data_model/booking_model.dart';
import 'package:ud_admin/features/booking/domain/booking_repo.dart';

part 'booking_data_event.dart';
part 'booking_data_state.dart';

class BookingDataBloc extends Bloc<BookingDataEvent, BookingDataState> {
  BookingRepo bookingrepo;
  BookingDataBloc(this.bookingrepo) : super(BookingDataState()) {
    on<BookingDataLoadingEvent>(loadingData);

    on<BookingDataLoadedEvent>(dataLoaded);
    on<UpcomingBookingEvent>(upcomingData);
  }

  FutureOr<void> loadingData(
      BookingDataLoadingEvent event, Emitter<BookingDataState> emit) {
    print("loading...");
  }

  FutureOr<void> dataLoaded(

  
      BookingDataLoadedEvent event, Emitter<BookingDataState> emit) async {

        emit(BookingDataInitialState());
    try {
      final bookingdatalist = await bookingrepo.getBookingData();
      emit(BookingDataLoadedState(bookingdataList: bookingdatalist));
    } catch (e) {
      print("error occured loading data ${e.toString()}");
    }
  }

  FutureOr<void> upcomingData(UpcomingBookingEvent event, Emitter<BookingDataState> emit)async {

    emit(BookingDataInitialState());
    final upcomingList = await bookingrepo.getUpcomingBooking();

   
    emit(UpcomingBookingState(upcomingBookingList: upcomingList));

  }
}
