import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'addcar_image_event.dart';
part 'addcar_image_state.dart';

class AddcarImageBloc extends Bloc<AddcarImageEvent, AddcarImageState> {
  AddcarImageBloc() : super(AddcarImageInitial()) {
    on<AddcarImageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
