import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ud_admin/features/dashboard/data/chart_model.dart';
import 'package:ud_admin/features/dashboard/domain/donut_chart_repo.dart';

part 'donut_chart_event.dart';
part 'donut_chart_state.dart';

class DonutChartBloc extends Bloc<DonutChartEvent, DonutChartState> {

  DonutChartRepo chartRepo;
  DonutChartBloc(this.chartRepo) : super(DonutChartState()) {

    on<FetchDonutChartEvent>(loadedStatusData);

  }

  FutureOr<void> loadedStatusData(FetchDonutChartEvent event, Emitter<DonutChartState> emit)async {

  
  }
}
