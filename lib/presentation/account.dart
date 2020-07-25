import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/security/security_bloc.dart';
import '../blocs/security/security_event.dart';
import '../blocs/security/security_state.dart';
import '../models/session.dart';
import '../smokes_app_core/routes.dart';
import '../smokes_app_core/src/keys.dart';
import '../smokes_app_core/src/localization.dart';

class Account extends StatelessWidget {
  Account({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildAccount(context);
  }

  Widget _buildAccount(BuildContext context) {
    // ignore: close_sinks
    final SecurityBloc securityBloc = BlocProvider.of<SecurityBloc>(context);

    securityBloc.listen((state) {
      if (state is LoggedOut) {
        Navigator.pushReplacementNamed(context, ArchRoutes.login);
      }
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CachedNetworkImage(
                imageUrl: Session.instance.userEntity.photoUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).name,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              Session.instance.userEntity.displayName,
              key: ArchSampleKeys.statsNumDaily,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).email,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              Session.instance.userEntity.email,
              key: ArchSampleKeys.statsNumMonthly,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: OutlineButton(
              onPressed: () {
                securityBloc.add(Logout());
              },
              child: Text("Logout"),
            ),
          )
        ],
      ),
    );
  }
}
