part of 'customers_list_bloc.dart';

sealed class CustomersListEvent extends Equatable {
  const CustomersListEvent();

  @override
  List<Object> get props => [];
}

class CustomerListLoadingEvent extends CustomersListEvent{} 
class CustomerListLoadedEvent extends CustomersListEvent{} 