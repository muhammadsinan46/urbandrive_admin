import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ud_admin/domain/category_model.dart';
import 'package:ud_admin/domain/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryRepo repo = CategoryRepo();
  CategoryBloc() : super(CategoryInitial()) {
      on<CateImageLoadingEvent>(loading);
      on<CateUploadImageEvent>(uplaodImage);
  }

  FutureOr<void> loading(CateImageLoadingEvent event, Emitter<CategoryState> emit) {
    print("loading");
  }

  FutureOr<void> uplaodImage(CateUploadImageEvent event, Emitter<CategoryState> emit)async {
      try{

        final image = await ImagePickerWeb.getImageAsBytes();
        emit(UploadCateImageState(cateImage: image!));

      }catch (e) {
      print("error is $e");
    }
  }
}
