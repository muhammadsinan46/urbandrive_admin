part of 'categorylist_bloc.dart';

sealed class CategorylistEvent extends Equatable {
  const CategorylistEvent();

  @override
  List<Object> get props => [];
}

class CateListLoadingEvent extends CategorylistEvent{}
class CateListLoadedEvent extends CategorylistEvent{

}
class CategorSearchEvent extends CategorylistEvent{

  String search;

    CategorSearchEvent({required this.search});
      @override
  List<Object> get props => [search];
}