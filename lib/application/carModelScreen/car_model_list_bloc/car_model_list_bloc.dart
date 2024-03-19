import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/domain/cardata_model.dart';
import 'package:ud_admin/domain/cardata_model_repo.dart';

part 'car_model_list_event.dart';
part 'car_model_list_state.dart';

class CarModelListBloc extends Bloc<CarModelListEvent, CarModelListState> {
  CarDataModelRepo cardatamodelRepo;
  CarModelListBloc(this.cardatamodelRepo) : super(CarModelListState()) {
    on<CarModelListInitialEvent>(loadingList);
  on<CarModelListLoadedEvent>(loadedList);
  }

  FutureOr<void> loadingList(CarModelListInitialEvent event, Emitter<CarModelListState> emit) {
    print("loading...");
  }

  FutureOr<void> loadedList(CarModelListLoadedEvent event, Emitter<CarModelListState> emit)async {

    emit(CarModelListInitial());

    try{
        
      final cardatalist = await cardatamodelRepo.getCarDataModels();



      emit(CarModelListUpdated(cardataList: cardatalist));

    }catch (e){
        print("error occured ${e.toString()}");
    }


  }
}
