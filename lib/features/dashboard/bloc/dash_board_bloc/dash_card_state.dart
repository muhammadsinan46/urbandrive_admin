part of 'dash_card_bloc.dart';

 class DashCardState extends Equatable {
  const DashCardState();
  
  @override
  List<Object> get props => [];
}

final class DashCardInitialState extends DashCardState {}
final class DashCardLoadedState extends DashCardState {

 final  DashCardModel dashcard;
  DashCardLoadedState({required this.dashcard});

  List<Object> get props =>[dashcard];

}
