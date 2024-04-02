part of 'dash_card_bloc.dart';

sealed class DashCardEvent extends Equatable {
  const DashCardEvent();

  @override
  List<Object> get props => [];
}

class DashCardLoadedEvent extends DashCardEvent{}

