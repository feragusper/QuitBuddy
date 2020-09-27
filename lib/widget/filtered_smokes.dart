import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_library_keys.dart';
import '../blocs/filtered_smokes/filtered_smokes_bloc.dart';
import '../blocs/filtered_smokes/filtered_smokes_state.dart';
import '../blocs/smokes/smokes_bloc.dart';
import '../blocs/smokes/smokes_event.dart';
import '../models/smoke.dart';
import '../presentation/details_screen.dart';
import '../smokes_app_core/keys.dart';
import '../smokes_app_core/localization.dart';
import 'delete_smoke_snack_bar.dart';
import 'loading_indicator.dart';
import 'smoke_item.dart';

class FilteredSmokes extends StatelessWidget {
  FilteredSmokes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final smokesBloc = BlocProvider.of<SmokesBloc>(context);

    return BlocBuilder<FilteredSmokesBloc, FilteredSmokesState>(
      builder: (
        BuildContext context,
        FilteredSmokesState state,
      ) {
        if (state is FilteredSmokesLoading) {
          return LoadingIndicator(key: ArchSampleKeys.smokesLoading);
        } else if (state is FilteredSmokesLoaded) {
          return _buildSmokeList(context, smokesBloc, state.smokes);
        } else {
          return Container(key: BlocLibraryKeys.filteredSmokesEmptyContainer);
        }
      },
    );
  }

  ListView _buildSmokeList(BuildContext context, SmokesBloc smokesBloc, List<Smoke> smokes) {
    final localizations = ArchSampleLocalizations.of(context);
    return ListView.builder(
      key: ArchSampleKeys.smokeList,
      itemCount: smokes.length,
      itemBuilder: (BuildContext context, int index) {
        final smoke = smokes[index];
        return SmokeItem(
          smoke: smoke,
          onDismissed: (_) {
            smokesBloc.add(DeleteSmoke(smoke));
            Scaffold.of(context).showSnackBar(DeleteSmokeSnackBar(
              key: ArchSampleKeys.snackbar,
              smoke: smoke,
              onUndo: () => smokesBloc.add(AddSmoke(smoke)),
              localizations: localizations,
            ));
          },
          onTap: () async {
            final removedSmoke = await Navigator.of(context).push<Smoke>(
              MaterialPageRoute(builder: (_) {
                return DetailsScreen(
                  smoke: smoke, onDelete: null,
                );
              }),
            );
            if (removedSmoke != null) {
              Scaffold.of(context).showSnackBar(DeleteSmokeSnackBar(
                key: ArchSampleKeys.snackbar,
                smoke: smoke,
                onUndo: () => smokesBloc.add(AddSmoke(smoke)),
                localizations: localizations,
              ));
            }
          },
        );
      },
    );
  }
}
