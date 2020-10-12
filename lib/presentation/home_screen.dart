import 'package:QuitBuddy/widget/filter_button.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/localization.dart';
import '../blocs/smokes/smokes_bloc.dart';
import '../blocs/smokes/smokes_event.dart';
import '../blocs/tab/tab_bloc.dart';
import '../blocs/tab/tab_event.dart';
import '../models/app_tab.dart';
import '../models/smoke.dart';
import '../widget/tab_selector.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  TabBloc tabBloc;
  SmokesBloc smokesBloc;

  @override
  void initState() {
    super.initState();
    tabBloc = BlocProvider.of<TabBloc>(context);
    smokesBloc = BlocProvider.of<SmokesBloc>(context);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
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
              // ignore: missing_required_param
              child: FloatingActionBubble(
                items: <Bubble>[
                  // Floating action menu item
                  Bubble(
                    title: "Homemade",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.settings,
                    titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      smokesBloc.add(AddSmoke(Smoke(date: new DateTime.now(), smokeType: SmokeType.HOMEMADE)));
                      _animationController.reverse();
                    },
                  ),
                  Bubble(
                    title: "Industrial",
                    iconColor: Colors.white,
                    bubbleColor: Colors.blue,
                    icon: Icons.settings,
                    titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () {
                      smokesBloc.add(AddSmoke(Smoke(date: new DateTime.now(), smokeType: SmokeType.INDUSTRIAL)));
                      _animationController.reverse();
                    },
                  ),
                ],
                // animation controller
                animation: _animation,

                // On pressed change animation state
                onPress: () {
                  _animationController.isCompleted ? _animationController.reverse() : _animationController.forward();
                },

                // Floating Action button Icon color
                animatedIconData: AnimatedIcons.add_event
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
