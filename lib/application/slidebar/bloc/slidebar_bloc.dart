import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'slidebar_event.dart';
part 'slidebar_state.dart';

class SlidebarBloc extends Bloc<SlidebarEvent, SlidebarState> {
  SlidebarBloc() : super(const SlidebarSuccessState(index:0)) {
    on<SlidebarEvent>((event, emit) {
        if(event is SlidebarChangeEvent){

          emit(SlidebarSuccessState(index: event.index));
        }
    });
  }
}
