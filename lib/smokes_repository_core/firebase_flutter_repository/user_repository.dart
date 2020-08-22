import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../src/user_entity.dart';
import '../src/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    Future<UserEntity> loginWithGoogle() async {
        final GoogleSignInAccount googleUser = await googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
        );

        final FirebaseUser user = (await auth.signInWithCredential(credential)).user;

        return UserEntity(user.uid, user.displayName, user.photoUrl, user.email);
    }

    @override
    Future<void> logout() async {
        await googleSignIn.signOut();
        await auth.signOut();
    }

    @override
    Future<UserEntity> getCurrentUser() async {
        bool isSignedIn = await googleSignIn.isSignedIn();
        FirebaseUser user = await auth.currentUser();
        if (isSignedIn && user != null) {
            return UserEntity(user.uid, user.displayName, user.photoUrl, user.email);
        }

        return null;
    }
}
