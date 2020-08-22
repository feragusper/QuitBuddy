import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/smoke.dart';
import '../smokes_app_core/src/keys.dart';

class SmokeItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Smoke smoke;

  SmokeItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.smoke,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.smokeItem(smoke.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Hero(
          tag: '${smoke.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "${new DateFormat('HH:mm').format(smoke.date)} hs",
              key: ArchSampleKeys.smokeItemTime(smoke.id),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: Text(
          "${new DateFormat('MM/dd').format(smoke.date)}",
          key: ArchSampleKeys.smokeItemDate(smoke.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
