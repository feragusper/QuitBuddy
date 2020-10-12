import 'package:QuitBuddy/models/smoke.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_library_keys.dart';
import '../blocs/stats/stats_bloc.dart';
import '../blocs/stats/stats_state.dart';
import '../widget/loading_indicator.dart';

class Stats extends StatelessWidget {
  Stats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final statsBloc = BlocProvider.of<StatsBloc>(context);
    return BlocBuilder(
      bloc: statsBloc,
      builder: (BuildContext context, StatsState state) {
        return BlocBuilder<StatsBloc, StatsState>(
          builder: (
            BuildContext context,
            StatsState state,
          ) {
            if (state is StatsLoading) {
              return LoadingIndicator(key: BlocLibraryKeys.statsLoadingIndicator);
            } else if (state is StatsLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Industrial Total: ${state.statsByType[SmokeType.INDUSTRIAL].totalSmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Industrial Monthly: ${state.statsByType[SmokeType.INDUSTRIAL].monthlySmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Industrial Daily: ${state.statsByType[SmokeType.INDUSTRIAL].dailySmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Industrial Daily Average: ${state.statsByType[SmokeType.INDUSTRIAL].dailyAverage}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Homemade Total: ${state.statsByType[SmokeType.HOMEMADE].totalSmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Homemade Monthly: ${state.statsByType[SmokeType.HOMEMADE].monthlySmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Homemade Daily: ${state.statsByType[SmokeType.HOMEMADE].dailySmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Homemade Daily Average: ${state.statsByType[SmokeType.HOMEMADE].dailyAverage}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Total: ${state.statsTotal.totalSmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Monthly: ${state.statsTotal.monthlySmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Daily: ${state.statsTotal.dailySmokeQuantity}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Daily Average: ${state.statsTotal.dailyAverage}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container(key: BlocLibraryKeys.emptyStatsContainer);
            }
          },
        );
      },
    );
  }
}
