import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../src/user_entity.dart';
import '../src/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth auth;

  const FirebaseUserRepository(this.auth);

  Future<UserEntity> loginWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await auth.signInWithCredential(credential)).user;

    return UserEntity(user.uid, user.displayName, user.photoUrl, user.email);
  }

  @override
  Future<UserEntity> logout() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    bool isSignedIn = await GoogleSignIn().isSignedIn();
    FirebaseUser user = await auth.currentUser();
    if (isSignedIn && user != null) {
      return UserEntity(user.uid, user.displayName, user.photoUrl, user.email);
    }

    return null;
  }
}
