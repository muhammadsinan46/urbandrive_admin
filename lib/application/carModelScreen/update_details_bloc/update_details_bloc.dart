import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/domain/car_model_repo.dart';

part 'update_details_event.dart';
part 'update_details_state.dart';

class UpdateDetailsBloc extends Bloc<UpdateDetailsEvent, UpdateDetailsState> {
    CarModelRepo carmodelrepo;
  UpdateDetailsBloc(this.carmodelrepo) : super(UpdateDetailsInitiaState()) {
    
    on<UpdateDetailsInitialEvent>(loadingdetails);
    on<UpdatedDetailsEvent>(loadedDetails);
  }




  FutureOr<void> loadingdetails(UpdateDetailsInitialEvent event, Emitter<UpdateDetailsState> emit) {
    print("loading data");
  }

  FutureOr<void> loadedDetails(UpdatedDetailsEvent event, Emitter<UpdateDetailsState> emit) async{
    try{
           final categoryList = await carmodelrepo.uploadCategoryList();
      final brandnameList = await carmodelrepo.uploadBrandList();
      emit(UpdatedDetailsState(categoryList: categoryList, brandnameList: brandnameList));

    }catch (e){

      print("error occured ${e.toString()}");

    }
  }
}
