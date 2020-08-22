import 'package:equatable/equatable.dart';

import '../../models/smoke.dart';
import '../../models/visibility_filter.dart';

abstract class FilteredSmokesState extends Equatable {
  const FilteredSmokesState();

  @override
  List<Object> get props => [];
}

class FilteredSmokesLoading extends FilteredSmokesState {}

class FilteredSmokesLoaded extends FilteredSmokesState {
  final List<Smoke> smokes;
  final VisibilityFilter activeFilter;

  const FilteredSmokesLoaded(
    this.smokes,
    this.activeFilter,
  );

  @override
  List<Object> get props => [smokes, activeFilter];

  @override
  String toString() {
    return 'FilteredSmokesLoaded { filteredSmokes: $smokes, activeFilter: $activeFilter }';
  }
}
