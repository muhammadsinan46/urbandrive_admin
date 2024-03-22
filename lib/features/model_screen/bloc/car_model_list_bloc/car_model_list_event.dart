part of 'car_model_list_bloc.dart';

 class CarModelListEvent extends Equatable {
  const CarModelListEvent();

  @override
  List<Object> get props => [];
}

class CarModelListInitialEvent extends CarModelListEvent{}
class CarModelListLoadedEvent extends CarModelListEvent{}