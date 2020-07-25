import 'package:equatable/equatable.dart';

import '../../models/smoke.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<Smoke> monthlySmokes;
  final List<Smoke> dailySmokes;

  const UpdateStats(this.monthlySmokes, this.dailySmokes);

  @override
  List<Object> get props => [monthlySmokes, dailySmokes];

  @override
  String toString() => 'UpdateStats { monthlySmokes: $monthlySmokes, dailySmokes: $dailySmokes }';
}
