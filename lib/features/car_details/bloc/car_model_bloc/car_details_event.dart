part of 'car_details_bloc.dart';

sealed class CarDetailsEvent extends Equatable {
  const CarDetailsEvent();

  @override
  List<Object> get props => [];
}


class CarDetailsLoadedEvent extends CarDetailsEvent{}