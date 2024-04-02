part of 'donut_chart_bloc.dart';

sealed class DonutChartEvent extends Equatable {
  const DonutChartEvent();

  @override
  List<Object> get props => [];
}
class FetchDonutChartEvent extends  DonutChartEvent{

  final DateTime selectedDate;

  FetchDonutChartEvent({required this.selectedDate});

}