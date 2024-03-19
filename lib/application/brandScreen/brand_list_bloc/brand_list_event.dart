part of 'brand_list_bloc.dart';

 sealed class BrandListEvent extends Equatable {
  const BrandListEvent();

  @override
  List<Object> get props => [];
}

class BrandListLoadingEvent extends BrandListEvent{}
class BrandListLoadedEvent extends BrandListEvent{}
