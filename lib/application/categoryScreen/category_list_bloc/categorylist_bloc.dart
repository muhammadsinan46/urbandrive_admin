import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/domain/category_model.dart';
import 'package:ud_admin/domain/category_repo.dart';

part 'categorylist_event.dart';
part 'categorylist_state.dart';

class CategorylistBloc extends Bloc<CategorylistEvent, CategorylistState> {
    CategoryRepo repo = CategoryRepo();
  CategorylistBloc(this.repo) : super(CategorylistState()) {

    on<CateListLoadingEvent>(listLoading);
    on<CateListLoadedEvent>(listLoaded);

  }

  FutureOr<void> listLoading(CateListLoadingEvent event, Emitter<CategorylistState> emit) {

    print("loading..");
  }

  FutureOr<void> listLoaded(CateListLoadedEvent event, Emitter<CategorylistState> emit)async {
    emit(CategorylistInitial());

    try{

      print("category is loading...");
            final  categoryList =await  repo.getCategoryData();

      emit(CategoryUpdatedState(categoryList: categoryList));

    }catch(e){
      print("error occured ${e.toString()}");
    }



  }
}
