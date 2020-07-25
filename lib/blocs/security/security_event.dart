
import 'package:equatable/equatable.dart';

class SecurityEvent extends Equatable {
    const SecurityEvent();

    @override
    List<Object> get props => [];
}

class Login extends SecurityEvent {
    const Login();

    @override
    String toString() => 'Login';
}

class CheckUserLoggedIn extends SecurityEvent {
    const CheckUserLoggedIn();

    @override
    String toString() => 'CheckUserLoggedIn';
}

class Logout extends SecurityEvent {
  const Logout();

  @override
  String toString() => 'Logout';
}