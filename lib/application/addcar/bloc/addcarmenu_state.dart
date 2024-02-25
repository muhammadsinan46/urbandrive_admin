part of 'addcarmenu_bloc.dart';

sealed class AddcarmenuState extends Equatable {
  const AddcarmenuState();
  
  @override
  List<Object> get props => [];
}

final class AddcarmenuInitial extends AddcarmenuState {}

final class AddCarChangedState extends AddcarmenuState{
      final String dropchangedvalue;

    const AddCarChangedState({required this.dropchangedvalue});

    @override
    List<Object> get props =>[dropchangedvalue];

}
