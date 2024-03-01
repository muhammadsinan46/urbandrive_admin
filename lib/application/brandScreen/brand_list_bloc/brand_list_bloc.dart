import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/domain/brand_model.dart';
import 'package:ud_admin/domain/brand_repo.dart';

part 'brand_list_event.dart';
part 'brand_list_state.dart';

class BrandListBloc extends Bloc<BrandListEvent, BrandListState> {
  BrandRepo brandRepo = BrandRepo();
  BrandListBloc(this.brandRepo) : super(BrandListInitial()) {
    on<BrandListLoadingEvent>(brandlistLaoding);
    on<BrandListLoadedEvent>(brandListLoaded);
  }

  FutureOr<void> brandlistLaoding(
      BrandListLoadingEvent event, Emitter<BrandListState> emit) {
    print("loading..");
  }

  FutureOr<void> brandListLoaded(
      BrandListLoadedEvent event, Emitter<BrandListState> emit) async {
    try {
      final brands = await brandRepo.getbrandData();
      emit(BrandLoadedList(brandList: brands));
    } catch (e) {
      print(e.toString());
    }
  }
}
