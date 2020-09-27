import 'dart:async';

import 'package:QuitBuddy/smokes_repository_core/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/session.dart';
import '../reactive_repository.dart';
import '../smoke_entity.dart';

class FirestoreReactiveSmokesRepository implements ReactiveSmokesRepository {
  static const String USERS_PATH = 'users';
  static const String SMOKES_PATH = 'smokes';

  final Firestore fireStore;

  FirestoreReactiveSmokesRepository(this.fireStore);

  @override
  Future<void> addNewSmoke(SmokeEntity smoke) {
    return getCurrentUserSmokesCollection().document(smoke.id).setData(smoke.toJson());
  }

  @override
  Future<void> deleteSmoke(List<String> idList) async {
    await Future.wait<void>(idList.map((id) {
      return getCurrentUserSmokesCollection().document(id).delete();
    }));
  }

  @override
  Future<List<SmokeEntity>> smokes() async {
    CollectionReference collectionReference = getCurrentUserSmokesCollection();
    Stream<List<SmokeEntity>> stream = collectionReference.orderBy("date", descending: true).snapshots().map((snapshot) {
      return snapshot.documents.map((doc) {
        return SmokeEntity(
          doc.documentID,
          (doc['date'] as Timestamp).toDate(),
        );
      }).toList();
    });

    await for (List<SmokeEntity> value in stream) {
      return value;
    }

    return null;
  }

  @override
  Future<int> totalSmokesCount() async {
    return getCurrentUserSmokesCollection().snapshots().length;
  }

  CollectionReference getCurrentUserSmokesCollection() {
    UserEntity userEntity = Session.instance.userEntity;
    return fireStore.collection(USERS_PATH).document(userEntity.id).collection(SMOKES_PATH);
  }
}
