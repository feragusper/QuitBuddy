import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
              "${smoke.date}",
//              "${new DateFormat('HH:mm').format(smoke.date)} hs",
              key: ArchSampleKeys.smokeItemTask(smoke.id),
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: Text(
//          "${new DateFormat('MM/dd').format(smoke.date)}",
          "${smoke.date}",
          key: ArchSampleKeys.smokeItemNote(smoke.id),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
