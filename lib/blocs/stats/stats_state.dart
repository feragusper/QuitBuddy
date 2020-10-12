import 'package:QuitBuddy/models/smoke.dart';
import 'package:equatable/equatable.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final Map<SmokeType, Stats> statsByType;
  final Stats statsTotal;

  const StatsLoaded(this.statsByType, this.statsTotal);

  @override
  List<Object> get props => [statsByType, statsTotal];

  @override
  String toString() {
    return 'StatsLoaded { statsByType: $statsByType, statsTotal: $statsTotal }';
  }
}

class Stats {
  final int dailySmokeQuantity;
  final int monthlySmokeQuantity;
  final int totalSmokeQuantity;
  final int dailyAverage;

  const Stats(this.dailySmokeQuantity, this.monthlySmokeQuantity, this.totalSmokeQuantity, this.dailyAverage);

  @override
  String toString() {
    return 'Stats { dailySmokes: $dailySmokeQuantity, monthlySmokes: $monthlySmokeQuantity, totalSmokes: $totalSmokeQuantity }';
  }
}
