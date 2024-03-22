part of 'car_details_list_bloc.dart';

sealed class CarDetailsListEvent extends Equatable {
  const CarDetailsListEvent();

  @override
  List<Object> get props => [];
}

class CarDetailsListLoadedEvent extends CarDetailsListEvent{

}
