import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/features/dashboard/data/dash_card_model.dart';
import 'package:ud_admin/features/dashboard/domain/dashboard_repo.dart';

part 'dash_card_event.dart';
part 'dash_card_state.dart';

class DashCardBloc extends Bloc<DashCardEvent, DashCardState> {

  final DashBoardRepo dashrepo;
  DashCardBloc(this.dashrepo) : super(DashCardState()) {


    on<DashCardLoadedEvent>(dashCardLoading);
  }

  FutureOr<void> dashCardLoading(DashCardLoadedEvent event, Emitter<DashCardState> emit)async {

    final  dashCard =await dashrepo.getCardDetails();

    emit(DashCardLoadedState(dashcard: dashCard));
  }
}
