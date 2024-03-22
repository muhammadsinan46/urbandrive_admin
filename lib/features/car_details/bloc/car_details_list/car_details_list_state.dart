part of 'car_details_list_bloc.dart';

 class CarDetailsListState extends Equatable {
  const CarDetailsListState();
  
  @override
  List<Object> get props => [];
}

final class CarDetailsListInitialState extends CarDetailsListState {}
final class CarDetailsListLoadedState extends CarDetailsListState {

 final  List<CarDetails> cardetailsList;
  CarDetailsListLoadedState({required this.cardetailsList});

  List<Object> get props =>[cardetailsList];
  
}
