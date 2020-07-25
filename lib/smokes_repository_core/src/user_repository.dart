import 'dart:async';

import 'user_entity.dart';

abstract class UserRepository {

  Future<UserEntity> loginWithGoogle();

  Future<void> logout();

  Future<UserEntity> getCurrentUser();
}