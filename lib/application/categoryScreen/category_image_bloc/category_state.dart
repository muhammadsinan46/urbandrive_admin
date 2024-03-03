part of 'category_bloc.dart';

 class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}



final class CategoryInitial extends CategoryState {}
final class UploadCateImageState extends CategoryState{
  final Uint8List cateImage ;
  const UploadCateImageState({required this.cateImage});

  @override
  List<Object> get props =>[cateImage]; 
}
