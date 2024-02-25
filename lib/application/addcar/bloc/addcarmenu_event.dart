part of 'addcarmenu_bloc.dart';

sealed class AddcarmenuEvent extends Equatable {
  const AddcarmenuEvent();

  @override
  List<Object> get props => [];



}
   class AddCarChangedEvent extends AddcarmenuEvent{

    final String dropchangedvalue;
   const AddCarChangedEvent({required this.dropchangedvalue});




  }
