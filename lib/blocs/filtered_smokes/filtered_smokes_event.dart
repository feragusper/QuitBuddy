import 'package:equatable/equatable.dart';

import '../../models/smoke.dart';
import '../../models/visibility_filter.dart';

abstract class FilteredSmokesEvent extends Equatable {
  const FilteredSmokesEvent();
}

class UpdateFilter extends FilteredSmokesEvent {
  final VisibilityFilter filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

class UpdateSmokes extends FilteredSmokesEvent {
  final List<Smoke> smokes;

  const UpdateSmokes(this.smokes);

  @override
  List<Object> get props => [smokes];

  @override
  String toString() => 'UpdateSmokes { smokes: $smokes }';
}
