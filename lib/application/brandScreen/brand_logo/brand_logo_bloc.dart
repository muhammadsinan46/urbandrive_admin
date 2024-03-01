import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'brand_logo_event.dart';
part 'brand_logo_state.dart';

class BrandLogoBloc extends Bloc<BrandLogoEvent, BrandLogoState> {
  BrandLogoBloc() : super(BrandLogoLoading()) {
 
 on<LogoLoadingEvent>(logoLoading);

 on<LogoLoadedEvent>(logoLoaded);
  }

  FutureOr<void> logoLoading(LogoLoadingEvent event, Emitter<BrandLogoState> emit) {
    print("loading..");
  }

  FutureOr<void> logoLoaded(LogoLoadedEvent event, Emitter<BrandLogoState> emit)async {

try{
      final image = await ImagePickerWeb.getImageAsBytes();

    emit(BrandLogoUpdated(brandlogo: image!));

}catch (e){

  print(e.toString());
}

  }
}
