import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/domain/customer_repo.dart';
import 'package:ud_admin/domain/customers_model.dart';

part 'customers_list_event.dart';
part 'customers_list_state.dart';

class CustomersListBloc extends Bloc<CustomersListEvent, CustomersListState> {

  final CustomersRepo customersRepo;
  CustomersListBloc(this.customersRepo) : super(CustomersListLoading()) {

    on<CustomerListLoadingEvent>(customerLoading);
    on<CustomerListLoadedEvent>(listLoaded);

  }

  FutureOr<void> customerLoading(CustomerListLoadingEvent event, Emitter<CustomersListState> emit) {
    print("loading...");
  }

  FutureOr<void> listLoaded(CustomerListLoadedEvent event, Emitter<CustomersListState> emit)async {
try{

      final customerlist = await customersRepo.getcustomersList();

    emit(CustomersListLoaded(customersList: customerlist));
}catch (e){

  print("error is ${e.toString()}");
}
  }
}
