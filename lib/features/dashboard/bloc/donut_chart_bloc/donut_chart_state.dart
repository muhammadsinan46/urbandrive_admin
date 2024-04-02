part of 'donut_chart_bloc.dart';

 class DonutChartState extends Equatable {
  const DonutChartState();
  
  @override
  List<Object> get props => [];
}

final class DonutChartInitial extends DonutChartState {}
final class DonutChartLoaded extends DonutChartState {

final List<ChartModel> chartValues;
DonutChartLoaded({required this.chartValues});

List<Object> get props =>[chartValues];


  
}
