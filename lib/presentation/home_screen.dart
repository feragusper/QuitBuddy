import 'package:QuitBuddy/widget/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/localization.dart';
import '../blocs/smokes/smokes_bloc.dart';
import '../blocs/smokes/smokes_event.dart';
import '../blocs/tab/tab_bloc.dart';
import '../blocs/tab/tab_event.dart';
import '../models/app_tab.dart';
import '../models/smoke.dart';
import '../smokes_app_core/src/keys.dart';
import '../smokes_app_core/src/localization.dart';
import '../widget/tab_selector.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);
    final smokesBloc = BlocProvider.of<SmokesBloc>(context);
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
            actions: [
              FilterButton(visible: activeTab == AppTab.smokes),
            ],
          ),
          body: activeTab.contentWidget,
          floatingActionButton: new Visibility(
              visible: activeTab.showFAB,
              child: FloatingActionButton(
                key: ArchSampleKeys.addSmokeFab,
                onPressed: () {
                  smokesBloc.add(AddSmoke(Smoke(date: new DateTime.now())));
                },
                child: Icon(Icons.add),
                tooltip: ArchSampleLocalizations.of(context).addSmoke,
              )),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => tabBloc.add(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}
