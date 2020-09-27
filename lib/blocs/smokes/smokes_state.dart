import 'package:equatable/equatable.dart';

import '../../models/smoke.dart';

abstract class SmokesState extends Equatable {
  const SmokesState();

  @override
  List<Object> get props => [];
}

class SmokesLoading extends SmokesState {}

class SmokesLoaded extends SmokesState {
  final List<Smoke> monthlySmokes;
  final List<Smoke> dailySmokes;
  final List<Smoke> totalSmokes;

  const SmokesLoaded([this.totalSmokes = const [], this.monthlySmokes = const [], this.dailySmokes = const []]);

  @override
  List<Object> get props => [totalSmokes, monthlySmokes, dailySmokes];

  @override
  String toString() => 'SmokesLoaded { totalSmokes: $totalSmokes, monthlySmokes: $monthlySmokes, dailySmokes: $dailySmokes }';
}

class SmokesNotLoaded extends SmokesState {}
