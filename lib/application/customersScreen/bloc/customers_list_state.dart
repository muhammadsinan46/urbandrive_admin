part of 'customers_list_bloc.dart';

sealed class CustomersListState extends Equatable {
  const CustomersListState();
  
  @override
  List<Object> get props => [];
}

final class CustomersListLoading extends CustomersListState {}
final class CustomersListLoaded extends CustomersListState {

  final List<CustomersModel> customersList;

  CustomersListLoaded({required this.customersList});

  @override
  List<Object> get props => [customersList];
}
