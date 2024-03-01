import 'dart:async';
import 'dart:js_interop';

import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ud_admin/domain/car_model_repo.dart';

part 'carscreen_event.dart';
part 'carscreen_state.dart';

class CarscreenBloc extends Bloc<CarscreenEvent, CarscreenState> {
  CarModelRepo carmodelrepo;
  CarscreenBloc(this.carmodelrepo) : super(CarscreenInitial()) {
    on<CarsreenloadingEvent>(loading);
    on<UploadImageEvent>(uploadImage);
    on<UploadDataEvent>(uploadData);
  }

  FutureOr<void> uploadImage(
      UploadImageEvent event, Emitter<CarscreenState> emit) async {
    print("state is loading ");
    try {
      final image = await ImagePickerWeb.getMultiImagesAsBytes();

      if (image!.length > 4) {
      } else {
        emit(UploadImageState(imageFile: image));
      }
    } catch (e) {
      print("error is $e");
    }
  }

  FutureOr<void> loading(
      CarsreenloadingEvent event, Emitter<CarscreenState> emit) {
    print("loading...");
  }

  FutureOr<void> uploadData(
      UploadDataEvent event, Emitter<CarscreenState> emit) async {
    try {
      final categoryList = await carmodelrepo.uploadCategoryList();
      final brandnameList = await carmodelrepo.uploadBrandList();
      emit(UploadDataState(
          categoryList: categoryList, brandnameList: brandnameList));
    } catch (e) {
      print("uploaded data error occured ${e.toString()}");
    }
  }
}
