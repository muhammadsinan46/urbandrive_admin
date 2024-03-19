part of 'car_model_list_bloc.dart';

 class CarModelListState extends Equatable {
  const CarModelListState();
  
  @override
  List<Object> get props => [];
}

final class CarModelListInitial extends CarModelListState {
  @override
  List<Object> get props =>[];
}

final class CarModelListUpdated extends CarModelListState {
 final  List<CarDataModel> cardataList;
 const  CarModelListUpdated({required this.cardataList});
@override
  List<Object> get props =>[cardataList];
}

