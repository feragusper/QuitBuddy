import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/filtered_smokes/filtered_smokes_bloc.dart';
import '../blocs/filtered_smokes/filtered_smokes_event.dart';
import '../blocs/filtered_smokes/filtered_smokes_state.dart';
import '../models/visibility_filter.dart';
import '../smokes_app_core/src/keys.dart';
import '../smokes_app_core/src/localization.dart';

class FilterButton extends StatelessWidget {
  final bool visible;

  FilterButton({this.visible, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyText2;
    final activeStyle = Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).accentColor);
    // ignore: close_sinks
    final filteredSmokesBloc = BlocProvider.of<FilteredSmokesBloc>(context);
    return BlocBuilder(
        bloc: filteredSmokesBloc,
        builder: (BuildContext context, FilteredSmokesState state) {
          final button = _Button(
            onSelected: (filter) {
              filteredSmokesBloc.add(UpdateFilter(filter));
            },
            activeFilter: state is FilteredSmokesLoaded ? state.activeFilter : VisibilityFilter.daily,
            activeStyle: activeStyle,
            defaultStyle: defaultStyle,
          );
          return AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 150),
            child: visible ? button : IgnorePointer(child: button),
          );
        });
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeFilter,
    @required this.activeStyle,
    @required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: ArchSampleKeys.filterButton,
      tooltip: ArchSampleLocalizations.of(context).filterSmokes,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            ArchSampleLocalizations.of(context).showAll,
            style: activeFilter == VisibilityFilter.all ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.monthlyFilter,
          value: VisibilityFilter.monthly,
          child: Text(
            ArchSampleLocalizations.of(context).showMonthly,
            style: activeFilter == VisibilityFilter.monthly ? activeStyle : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.dailyFilter,
          value: VisibilityFilter.daily,
          child: Text(
            ArchSampleLocalizations.of(context).showDaily,
            style: activeFilter == VisibilityFilter.daily ? activeStyle : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
