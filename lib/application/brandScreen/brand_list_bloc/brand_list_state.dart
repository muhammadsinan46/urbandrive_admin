part of 'brand_list_bloc.dart';

 class BrandListState extends Equatable {
  const BrandListState();
  
  @override
  List<Object> get props => [];
}

final class BrandListInitial extends BrandListState {}
final class BrandLoadedList extends BrandListState{
 final  List<BrandModel> brandList;

 const  BrandLoadedList({required this.brandList});

  @override
  List<Object> get props =>[brandList];
}
