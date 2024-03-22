import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/domain/car_details_repo.dart';

part 'car_details_event.dart';
part 'car_details_state.dart';

class CarDetailsBloc extends Bloc<CarDetailsEvent, CarDetailsState> {
  CarDetailsRepo cardetailsRepo;
  CarDetailsBloc(this.cardetailsRepo) : super(CarDetailsState()) {


    on<CarDetailsLoadedEvent>(cardetailsLoad);
  }

  FutureOr<void> cardetailsLoad(CarDetailsLoadedEvent event, Emitter<CarDetailsState> emit) async{

try{
 final carmodeldetails = await cardetailsRepo.getCarModelDetails();



 emit(CarDetailsLoadedState(carmodelList: carmodeldetails,));


}catch(e){
  print(e.toString());
}

  }
}
