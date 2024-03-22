part of 'brand_list_bloc.dart';

 class BrandListState extends Equatable {
  const BrandListState();
  
  @override
  List<Object> get props => [];
}

final class BrandListInitial extends BrandListState {
    @override
  List<Object> get props =>[];
}
final class BrandLoadedList extends BrandListState{
 final  List<BrandModel> brandList;

   BrandLoadedList({required this.brandList});

  @override
  List<Object> get props =>[brandList];
}
