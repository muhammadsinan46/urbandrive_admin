import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'addcarmenu_event.dart';
part 'addcarmenu_state.dart';

class AddcarmenuBloc extends Bloc<AddcarmenuEvent, AddcarmenuState> {
  AddcarmenuBloc() : super(AddcarmenuInitial()) {
    on<AddcarmenuEvent>((event, emit) {
          if(event is AddCarChangedEvent){
            print("event is ${event.dropchangedvalue}");
            emit(AddCarChangedState(dropchangedvalue: event.dropchangedvalue));
          }
    });
  }
}
