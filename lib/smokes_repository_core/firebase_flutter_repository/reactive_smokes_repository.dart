import 'dart:async';

import 'package:QuitBuddy/smokes_repository_core/src/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../models/session.dart';
import '../src/reactive_repository.dart';
import '../src/smoke_entity.dart';

class FirestoreReactiveSmokesRepository implements ReactiveSmokesRepository {
  static const String users_path = 'users';
  static const String smokes_path = 'smokes';

  final Firestore firestore;

  FirestoreReactiveSmokesRepository(this.firestore);

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
  Future<List<SmokeEntity>> dailySmokes() async {
    debugPrint("FirestoreReactiveSmokesRepository dailySmokes");
    Stream<List<SmokeEntity>> stream = getCurrentUserSmokesCollection()
        .where("date", isGreaterThanOrEqualTo: DateTime.parse(new DateFormat('yyyyMMdd').format(new DateTime.now())))
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {
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
  Future<List<SmokeEntity>> monthlySmokes() async {
    CollectionReference collectionReference = getCurrentUserSmokesCollection();
    Stream<List<SmokeEntity>> stream = collectionReference
        .where("date", isGreaterThanOrEqualTo: DateTime.parse(new DateFormat('yyyyMM01').format(new DateTime.now())))
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {
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

  CollectionReference getCurrentUserSmokesCollection() {
    UserEntity userEntity = Session.instance.userEntity;
    return firestore.collection(users_path).document(userEntity.id).collection(smokes_path);
  }
}
