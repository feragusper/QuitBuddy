
import 'package:equatable/equatable.dart';

import '../../smokes_repository_core/src/user_entity.dart';

class SecurityState extends Equatable {
    const SecurityState();

    @override
    List<Object> get props => [];
}

class LoginInitLoading extends SecurityState {}

class LoginLogoutLoading extends SecurityState {}

class LoggedIn extends SecurityState {
    final UserEntity userEntity;

    const LoggedIn([this.userEntity]);

    @override
    List<Object> get props => [userEntity];

    @override
    String toString() => 'LoggedIn { userEntity: $userEntity }';
}

class LoggedOut extends SecurityState {}

class Error extends SecurityState {
    final String message;

    const Error([this.message]);

    @override
    List<Object> get props => [message];

    @override
    String toString() => 'Error { message: $message }';
}
