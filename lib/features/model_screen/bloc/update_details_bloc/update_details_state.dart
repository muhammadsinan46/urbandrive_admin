part of 'update_details_bloc.dart';

 class UpdateDetailsState extends Equatable {
  const UpdateDetailsState();
  
  @override
  List<Object> get props => [];
}

final class UpdateDetailsInitiaState extends UpdateDetailsState {}
class UpdatedDetailsState extends UpdateDetailsState{
  final List<String> categoryList;
  final List<String> brandnameList;
 const  UpdatedDetailsState({required this.categoryList, required this.brandnameList});

  @override
  List<Object> get props =>[categoryList, brandnameList];


}
