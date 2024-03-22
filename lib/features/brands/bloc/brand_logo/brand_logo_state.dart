part of 'brand_logo_bloc.dart';

sealed class BrandLogoState extends Equatable {
  const BrandLogoState();
  
  @override
  List<Object> get props => [];
}

final class BrandLogoLoading extends BrandLogoState {}
final class BrandLogoUpdated extends BrandLogoState {

  final Uint8List brandlogo;
  const BrandLogoUpdated({required this.brandlogo});

  @override
  List<Object> get props =>[brandlogo];
}
