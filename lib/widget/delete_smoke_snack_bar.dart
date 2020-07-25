import 'package:flutter/material.dart';

import '../models/smoke.dart';
import '../smokes_app_core/src/localization.dart';

class DeleteSmokeSnackBar extends SnackBar {
  final ArchSampleLocalizations localizations;

  DeleteSmokeSnackBar({
    Key key,
    @required Smoke smoke,
    @required VoidCallback onUndo,
    @required this.localizations,
  }) : super(
          key: key,
          content: Text(
            localizations.smokeDeleted(smoke.id),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: localizations.undo,
            onPressed: onUndo,
          ),
        );
}
