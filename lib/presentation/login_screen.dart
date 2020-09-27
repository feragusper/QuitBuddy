import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/security/security_bloc.dart';
import '../blocs/security/security_event.dart';
import '../blocs/security/security_state.dart';
import '../models/session.dart';
import '../smokes_app_core/routes.dart';
import '../smokes_app_core/keys.dart';
import '../widget/error.dart';
import '../widget/loading_indicator.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var securityBloc;

  LoginScreen() : super(key: ArchSampleKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    securityBloc = BlocProvider.of<SecurityBloc>(context);

    securityBloc.listen((state) {
      if (state is LoggedIn) {
        Session.instance.setUserEntity(state.userEntity);
        Navigator.pushReplacementNamed(context, ArchRoutes.home);
      }
    });

    return BlocBuilder<SecurityBloc, SecurityState>(
      builder: (
        BuildContext context,
        SecurityState state,
      ) {
        if (state is LoginLogoutLoading || state is LoginInitLoading) {
          if (state is LoginInitLoading) {
            securityBloc.add(CheckUserLoggedIn());
          }
          return LoadingIndicator(key: ArchSampleKeys.generalLoading);
        } else if (state is Error) {
          return ErrorView(
            errorMessage: state.message,
            onRetryPressed: () => securityBloc.add(Login()),
          );
        } else {
          return Scaffold(
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: SizedBox(),
                            ),
                            _title(),
                            SizedBox(
                              height: 20,
                            ),
                            _googleButton(context),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
        }
      },
    );
  }

  Widget _googleButton(BuildContext context) {
    return Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: FlatButton(
          onPressed: () {
            securityBloc.add(Login());
          },
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
                  ),
                  alignment: Alignment.center,
                  child: Text('G', style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.w400)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                  ),
                  alignment: Alignment.center,
                  child: Text('Log in with Google', style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(text: 'Quit Buddy', style: TextStyle(color: Colors.white, fontSize: 30)),
    );
  }
}
