import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/filtered_smokes/filtered_smokes_bloc.dart';
import 'blocs/localization.dart';
import 'blocs/security/security_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'blocs/smokes/smokes_bloc.dart';
import 'blocs/smokes/smokes_event.dart';
import 'blocs/stats/stats_bloc.dart';
import 'blocs/tab/tab_bloc.dart';
import 'presentation/home_screen.dart';
import 'presentation/login_screen.dart';
import 'smokes_app_core/routes.dart';
import 'smokes_app_core/src/localization.dart';
import 'smokes_app_core/src/theme.dart';
import 'smokes_repository_core/firebase_flutter_repository/reactive_smokes_repository.dart';
import 'smokes_repository_core/firebase_flutter_repository/user_repository.dart';

void runBlocLibraryApp() {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(QuitBuddyApp());
}

class QuitBuddyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuitBuddyAppState();
  }
}

class QuitBuddyAppState extends State {
  var firebaseUserRepository;
  var firestoreInstance = Firestore.instance;
  var firestoreReactiveSmokesRepository;
  var smokesBloc;

  @override
  Widget build(BuildContext context) {
    firebaseUserRepository = FirebaseUserRepository();
    // This fixes the outdated data problem which was only solved by clearing local storage.
    firestoreInstance.settings(persistenceEnabled: false);
    firestoreReactiveSmokesRepository = FirestoreReactiveSmokesRepository(firestoreInstance);
    smokesBloc = SmokesBloc(smokesRepository: firestoreReactiveSmokesRepository);

    return MaterialApp(
      onGenerateTitle: (context) => FlutterBlocLocalizations.of(context).appTitle,
      theme: QuitBuddyTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        ArchRoutes.login: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<SecurityBloc>(
                create: (context) => SecurityBloc(userRepository: firebaseUserRepository),
              ),
            ],
            child: LoginScreen(),
          );
        },
        ArchRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<FilteredSmokesBloc>(
                create: (context) => FilteredSmokesBloc(smokesBloc: smokesBloc..add(LoadSmokes())),
              ),
              BlocProvider<SmokesBloc>(create: (context) {
                return smokesBloc..add(LoadSmokes());
              }),
              BlocProvider<StatsBloc>(
                create: (context) => StatsBloc(smokesBloc: smokesBloc),
              ),
              BlocProvider<SecurityBloc>(
                create: (context) => SecurityBloc(userRepository: firebaseUserRepository),
              ),
            ],
            child: HomeScreen(),
          );
        }
      },
    );
  }
}
