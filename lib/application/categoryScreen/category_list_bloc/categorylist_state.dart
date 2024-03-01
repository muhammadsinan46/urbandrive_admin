part of 'categorylist_bloc.dart';

sealed class CategorylistState extends Equatable {
  const CategorylistState();
  
  @override
  List<Object> get props => [];
}

final class CategorylistInitial extends CategorylistState{}
final class CategoryUpdatedState extends CategorylistState{
  List<CategoryModel> categoryList;

  CategoryUpdatedState({required this.categoryList});

  @override
  List<Object> get props =>[categoryList];

}
