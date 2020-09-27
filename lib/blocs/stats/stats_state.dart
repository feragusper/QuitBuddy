import 'package:equatable/equatable.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final int dailySmokes;
  final int monthlySmokes;
  final int totalSmokes;
  final int dailyAverage;

  const StatsLoaded(this.dailySmokes, this.monthlySmokes, this.totalSmokes, this.dailyAverage);

  @override
  List<Object> get props => [dailySmokes, monthlySmokes, totalSmokes];

  @override
  String toString() {
    return 'StatsLoaded { dailySmokes: $dailySmokes, monthlySmokes: $monthlySmokes, totalSmokes: $totalSmokes }';
  }
}
