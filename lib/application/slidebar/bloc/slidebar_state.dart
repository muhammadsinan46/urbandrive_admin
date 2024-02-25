part of 'slidebar_bloc.dart';

sealed class SlidebarState extends Equatable {
  const SlidebarState();
  
  @override
  List<Object> get props => [];
}




class SlidebarSuccessState extends SlidebarState{

  final int index;

  const SlidebarSuccessState({required this.index});
    @override
  List<Object> get props =>[index];
}
