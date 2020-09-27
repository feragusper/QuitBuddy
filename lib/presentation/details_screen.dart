import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/smoke.dart';
import '../smokes_app_core/keys.dart';
import '../smokes_app_core/localization.dart';

class DetailsScreen extends StatelessWidget {
  final Smoke smoke;
  final Function onDelete;

  DetailsScreen({
    Key key,
    @required this.smoke,
    @required this.onDelete,
  }) : super(key: key ?? ArchSampleKeys.smokeDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.smokeDetails),
        actions: [
          IconButton(
            tooltip: localizations.deleteSmoke,
            key: ArchSampleKeys.deleteSmokeButton,
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context, smoke);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: '${smoke.id}__heroTag',
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 16.0,
                          ),
                          child: Text(
                            "Cigarette smoked at ${new DateFormat('HH:mm').format(smoke.date)} hs",
                            key: ArchSampleKeys.detailsSmokeItemTime,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      Text(
                        "On date ${new DateFormat('MM/dd').format(smoke.date)}",
                        key: ArchSampleKeys.detailsSmokeItemDate,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
