import '../smokes_repository_core/src/user_entity.dart';

class Session {
  UserEntity userEntity;

  Session._privateConstructor();

  static final Session instance = Session._privateConstructor();

  void setUserEntity(UserEntity userEntity) {
    this.userEntity = userEntity;
  }
}
