import 'package:equatable/equatable.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final int numDaily;
  final int numMonthly;

  const StatsLoaded(this.numDaily, this.numMonthly);

  @override
  List<Object> get props => [numDaily, numMonthly];

  @override
  String toString() {
    return 'StatsLoaded { numDaily: $numDaily, numMonthly: $numMonthly }';
  }
}
