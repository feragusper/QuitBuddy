import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presentation/account_screen.dart';
import '../presentation/stats_screen.dart';
import '../smokes_app_core/keys.dart';
import '../smokes_app_core/localization.dart';
import '../widget/filtered_smokes.dart';

enum AppTab { smokes, stats, account }

extension AppTabWithIcon on AppTab {
  IconData get icon {
    switch (this) {
      case AppTab.smokes:
        return Icons.list;
      case AppTab.stats:
        return Icons.show_chart;
      case AppTab.account:
        return Icons.account_circle;
      default:
        return null;
    }
  }

  Key get key {
    switch (this) {
      case AppTab.smokes:
        return ArchSampleKeys.smokeTab;
      case AppTab.stats:
        return ArchSampleKeys.statsTab;
      case AppTab.account:
        return ArchSampleKeys.accountTab;
      default:
        return null;
    }
  }

  String makeTitle(BuildContext context) {
    switch (this) {
      case AppTab.smokes:
        return ArchSampleLocalizations.of(context).smokes;
      case AppTab.stats:
        return ArchSampleLocalizations.of(context).stats;
      case AppTab.account:
        return ArchSampleLocalizations.of(context).account;
      default:
        return null;
    }
  }

  bool get showFAB {
    switch (this) {
      case AppTab.smokes:
        return true;
      default:
        return false;
    }
  }

  Widget get contentWidget {
    switch (this) {
      case AppTab.smokes:
        return FilteredSmokes();
      case AppTab.stats:
        return Stats();
      case AppTab.account:
        return Account();
      default:
        return null;
    }
  }
}
