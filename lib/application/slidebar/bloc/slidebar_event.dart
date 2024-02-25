part of 'slidebar_bloc.dart';

abstract class SlidebarEvent extends Equatable {
  const SlidebarEvent();

  @override
  List<Object> get props => [];
}


class SlidebarChangeEvent  extends SlidebarEvent{

  final int index;

  const SlidebarChangeEvent({required this.index});


  
}