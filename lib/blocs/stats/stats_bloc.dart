import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../smokes/smokes_bloc.dart';
import '../smokes/smokes_state.dart';
import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final SmokesBloc smokesBloc;
  StreamSubscription smokesSubscription;

  StatsBloc({@required this.smokesBloc}) {
    smokesSubscription = smokesBloc.listen((state) {
      if (state is SmokesLoaded) {
        add(UpdateStats(state.monthlySmokes, state.dailySmokes));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      var numDaily = event.dailySmokes.length;
      var numMonthly = event.monthlySmokes.length;
      yield StatsLoaded(numDaily, numMonthly);
    }
  }

  @override
  Future<void> close() {
    smokesSubscription?.cancel();
    return super.close();
  }
}
