import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/domain/car_detail_model.dart';
import 'package:ud_admin/domain/car_details_repo.dart';


part 'car_details_list_event.dart';
part 'car_details_list_state.dart';

class CarDetailsListBloc extends Bloc<CarDetailsListEvent, CarDetailsListState> {

  CarDetailsRepo cardetails;
  CarDetailsListBloc(this.cardetails) : super(CarDetailsListState()) {

    on<CarDetailsListLoadedEvent>(cardetailsLoading);

  }

  FutureOr<void> cardetailsLoading(CarDetailsListLoadedEvent event, Emitter<CarDetailsListState> emit) async{

    final detaildataList =await cardetails.getCarDetails();

    emit(CarDetailsListLoadedState(cardetailsList: detaildataList));
  }
}
