import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_library_keys.dart';
import '../blocs/stats/stats_bloc.dart';
import '../blocs/stats/stats_state.dart';
import '../smokes_app_core/src/keys.dart';
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
                        '${state.totalSmokes}',
                        key: ArchSampleKeys.statsTotalSmokes,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        '${state.monthlySmokes}',
                        key: ArchSampleKeys.statsMonthlySmokes,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        '${state.dailySmokes}',
                        key: ArchSampleKeys.statsDailySmokes,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        '${state.dailyAverage}',
                        key: ArchSampleKeys.statsDailyAverageSmokes,
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
