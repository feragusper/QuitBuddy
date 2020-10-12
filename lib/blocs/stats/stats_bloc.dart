import 'dart:async';

import 'package:QuitBuddy/models/smoke.dart';
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
        add(UpdateStats(state.totalSmokes, state.monthlySmokes, state.dailySmokes));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      var industrialDailySmokes = event.dailySmokes.where((element) => element.smokeType == SmokeType.INDUSTRIAL).length;
      var industrialMonthlySmokes = event.monthlySmokes.where((element) => element.smokeType == SmokeType.INDUSTRIAL).length;
      var industrialTotalSmokes = event.totalSmokes.where((element) => element.smokeType == SmokeType.INDUSTRIAL).length;
      var daysPassedFromFirstIndustrialSmoke = DateTime.now().difference(event.totalSmokes.where((element) => element.smokeType == SmokeType.INDUSTRIAL).last.date).inDays;
      var industrialDailyAverage = (daysPassedFromFirstIndustrialSmoke > 0) ? industrialTotalSmokes ~/ daysPassedFromFirstIndustrialSmoke : industrialTotalSmokes;

      var homemadeDailySmokes = event.dailySmokes.where((element) => element.smokeType == SmokeType.HOMEMADE).length;
      var homemadeMonthlySmokes = event.monthlySmokes.where((element) => element.smokeType == SmokeType.HOMEMADE).length;
      var homemadeTotalSmokes = event.totalSmokes.where((element) => element.smokeType == SmokeType.HOMEMADE).length;
      var daysPassedFromFirstHomemadeSmoke = DateTime.now().difference(event.totalSmokes.where((element) => element.smokeType == SmokeType.HOMEMADE).last.date).inDays;
      var homemadeDailyAverage = (daysPassedFromFirstHomemadeSmoke > 0) ? homemadeTotalSmokes ~/ daysPassedFromFirstHomemadeSmoke : homemadeTotalSmokes;

      var daysPassedFromFirstSmoke = DateTime.now().difference(event.totalSmokes.last.date).inDays;
      yield StatsLoaded(
          {
            SmokeType.INDUSTRIAL: Stats(industrialDailySmokes, industrialMonthlySmokes, industrialTotalSmokes, industrialDailyAverage),
            SmokeType.HOMEMADE: Stats(homemadeDailySmokes, homemadeMonthlySmokes, homemadeTotalSmokes, homemadeDailyAverage),
          },
          Stats(event.dailySmokes.length, event.monthlySmokes.length, event.totalSmokes.length,
              (daysPassedFromFirstSmoke > 0) ? event.totalSmokes.length ~/ daysPassedFromFirstSmoke : event.totalSmokes.length));
    }
  }

  @override
  Future<void> close() {
    smokesSubscription?.cancel();
    return super.close();
  }
}
