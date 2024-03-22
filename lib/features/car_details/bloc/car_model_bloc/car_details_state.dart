part of 'car_details_bloc.dart';

 class CarDetailsState extends Equatable {
  const CarDetailsState();
  
  @override
  List<Object> get props => [];
}

final class CarDetailsInitialState extends CarDetailsState {}

final class CarDetailsLoadedState extends CarDetailsState {

  final List<Map<String, String >> carmodelList;  
 // final List<String> carBrandist;  
  CarDetailsLoadedState({required this.carmodelList,
  // required this.carBrandist
   });

  List<Object> get props =>[carmodelList];


}
