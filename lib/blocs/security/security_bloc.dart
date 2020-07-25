import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../smokes_repository_core/src/user_repository.dart';
import 'security_event.dart';
import 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  final UserRepository userRepository;

  SecurityBloc({@required this.userRepository});

  @override
  SecurityState get initialState => LoginInitLoading();

  @override
  Stream<SecurityState> mapEventToState(SecurityEvent event) async* {
    if (event is CheckUserLoggedIn) {
      yield* _mapCheckUserLoggedInToState();
    } else if (event is Login) {
      yield* _mapLoginToState();
    } else if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  Stream<SecurityState> _mapCheckUserLoggedInToState() async* {
    try {
      yield LoginLogoutLoading();
      final currentUser = await userRepository.getCurrentUser();
      if (currentUser != null) {
        yield LoggedIn(currentUser);
      } else {
        yield LoggedOut();
      }
    } catch (e) {
      yield Error(e.toString());
    }
  }

  Stream<SecurityState> _mapLoginToState() async* {
    try {
      yield LoginLogoutLoading();
      final userEntity = await userRepository.loginWithGoogle();
      yield LoggedIn(userEntity);
    } catch (e) {
      yield Error(e.toString());
    }
  }

  Stream<SecurityState> _mapLogoutToState() async* {
    try {
      await userRepository.logout();
      yield LoggedOut();
    } catch (_) {
      yield LoggedIn();
    }
  }
}
