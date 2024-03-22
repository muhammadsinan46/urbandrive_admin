import 'dart:async';


import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'carscreen_event.dart';
part 'carscreen_state.dart';

class CarscreenBloc extends Bloc<CarscreenEvent, CarscreenState> {

  CarscreenBloc() : super(CarscreenInitial()) {
    on<CarsreenloadingEvent>(loading);
    on<UploadImageEvent>(uploadImage);
    on<ModelImageUpdatedEvent>(updated);
    

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



  FutureOr<void> updated(ModelImageUpdatedEvent event, Emitter<CarscreenState> emit) {
    emit(UploadImageState(imageFile:const []));
    emit(CarscreenInitial());
  }
}
