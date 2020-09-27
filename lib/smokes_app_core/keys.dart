import 'package:flutter/widgets.dart';

class ArchSampleKeys {
  // General
  static const generalLoading = Key('__generalLoading__');

  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addSmokeFab = Key('__addSmokeFab__');
  static const snackbar = Key('__snackbar__');

  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Smokes
  static const smokeList = Key('__smokeList__');
  static const smokesLoading = Key('__smokesLoading__');
  static final smokeItem = (String id) => Key('SmokeItem__$id');
  static final smokeItemTime = (String id) => Key('SmokeItem__${id}__Time');
  static final smokeItemDate = (String id) => Key('SmokeItem__${id}__Date');

  // Tabs
  static const tabs = Key('__tabs__');
  static const smokeTab = Key('__smokeTab__');
  static const statsTab = Key('__statsTab__');
  static const accountTab = Key('__accountTab__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const dailyFilter = Key('__dailyFilter__');
  static const monthlyFilter = Key('__monthlyFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsDailySmokes = Key('__statsDailySmokes__');
  static const statsMonthlySmokes = Key('__statsMonthlySmokes__');
  static const statsTotalSmokes = Key('__statsTotalSmokes__');
  static const statsDailyAverageSmokes = Key('__statsDailyAverageSmokes__');

  // Details Screen
  static const deleteSmokeButton = Key('__deleteSmokeFab__');
  static const smokeDetailsScreen = Key('__smokeDetailsScreen__');
  static final detailsSmokeItemTime = Key('DetailsSmoke__Time');
  static final detailsSmokeItemDate = Key('DetailsSmoke__Date');
}
