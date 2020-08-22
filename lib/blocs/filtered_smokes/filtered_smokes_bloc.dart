import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/smoke.dart';
import '../../models/visibility_filter.dart';
import '../smokes/smokes_bloc.dart';
import '../smokes/smokes_state.dart';
import 'filtered_smokes_event.dart';
import 'filtered_smokes_state.dart';

class FilteredSmokesBloc extends Bloc<FilteredSmokesEvent, FilteredSmokesState> {
  final SmokesBloc smokesBloc;
  StreamSubscription smokesSubscription;

  FilteredSmokesBloc({@required this.smokesBloc}) {
    smokesSubscription = smokesBloc.listen((state) {
      if (state is SmokesLoaded) {
        add(UpdateSmokes(state.monthlySmokes));
      }
    });
  }

  @override
  FilteredSmokesState get initialState {
    return smokesBloc.state is SmokesLoaded
        ? FilteredSmokesLoaded(
            (smokesBloc.state as SmokesLoaded).dailySmokes,
            VisibilityFilter.daily,
          )
        : FilteredSmokesLoading();
  }

  @override
  Stream<FilteredSmokesState> mapEventToState(FilteredSmokesEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateSmokes) {
      yield* _mapSmokesUpdatedToState(event);
    }
  }

  Stream<FilteredSmokesState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    if (smokesBloc.state is SmokesLoaded) {
      yield FilteredSmokesLoaded(
        _mapSmokesToFilteredSmokes(
          filterSmokes((smokesBloc.state as SmokesLoaded), event.filter),
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredSmokesState> _mapSmokesUpdatedToState(
    UpdateSmokes event,
  ) async* {
    final visibilityFilter = state is FilteredSmokesLoaded ? (state as FilteredSmokesLoaded).activeFilter : VisibilityFilter.daily;

    yield FilteredSmokesLoaded(
      _mapSmokesToFilteredSmokes(
        filterSmokes((smokesBloc.state as SmokesLoaded), visibilityFilter),
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Smoke> _mapSmokesToFilteredSmokes(
    List<Smoke> smokes,
    VisibilityFilter filter,
  ) {
    return smokes.where((smoke) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.daily) {
        return true;
      } else {
        return true;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    smokesSubscription?.cancel();
    return super.close();
  }

  List<Smoke> filterSmokes(SmokesLoaded state, VisibilityFilter visibilityFilter) {
    if (visibilityFilter == VisibilityFilter.daily) {
      return state.dailySmokes;
    } else {
      return state.monthlySmokes;
    }
  }
}
