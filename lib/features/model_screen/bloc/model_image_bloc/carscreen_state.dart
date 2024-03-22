// ignore_for_file: must_be_immutable

part of 'carscreen_bloc.dart';

 class CarscreenState extends Equatable {
  const CarscreenState();
  
  @override
  List<Object> get props => [];
}

final class CarscreenInitial extends CarscreenState {}


class UploadImageState extends CarscreenState{

  List<Uint8List>  imageFile;

  UploadImageState({required this.imageFile});
    @override
  List<Object> get props =>[imageFile];
}




