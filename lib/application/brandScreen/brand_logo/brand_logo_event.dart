part of 'brand_logo_bloc.dart';

 class BrandLogoEvent extends Equatable {
  const BrandLogoEvent();

  @override
  List<Object> get props => [];
}


class LogoLoadingEvent extends BrandLogoEvent{}
class LogoLoadedEvent extends BrandLogoEvent{}

