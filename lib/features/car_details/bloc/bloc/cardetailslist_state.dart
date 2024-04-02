part of 'cardetailslist_bloc.dart';

sealed class CardetailslistState extends Equatable {
  const CardetailslistState();
  
  @override
  List<Object> get props => [];
}

final class CardetailslistInitial extends CardetailslistState {}
