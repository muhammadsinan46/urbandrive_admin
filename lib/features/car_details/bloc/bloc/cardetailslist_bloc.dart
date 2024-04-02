import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cardetailslist_event.dart';
part 'cardetailslist_state.dart';

class CardetailslistBloc extends Bloc<CardetailslistEvent, CardetailslistState> {
  CardetailslistBloc() : super(CardetailslistInitial()) {
    on<CardetailslistEvent>((event, emit) {
     
    });
  }
}
