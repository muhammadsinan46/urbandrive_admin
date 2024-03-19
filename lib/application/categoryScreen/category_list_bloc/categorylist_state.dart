part of 'categorylist_bloc.dart';

 class CategorylistState extends Equatable {
  const CategorylistState();
  
  @override
  List<Object> get props => [];
}

final class CategorylistInitial extends CategorylistState{

  @override
  List<Object> get props =>[];
}
final class CategoryUpdatedState extends CategorylistState{
  final List<CategoryModel> categoryList;

  CategoryUpdatedState({required this.categoryList});

  @override
  List<Object> get props =>[categoryList];

}

