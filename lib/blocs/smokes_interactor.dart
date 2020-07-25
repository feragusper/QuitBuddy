import 'dart:async';

import '../models/smoke.dart';
import '../smokes_repository_core/src/reactive_repository.dart';

class SmokesInteractor {
  final ReactiveSmokesRepository repository;

  SmokesInteractor(this.repository);

//  Stream<List<Smoke>> get monthlySmokes {
//    return repository.monthlySmokesAsStream().map((entities) {
//      return entities.map(Smoke.fromEntity).toList();
//    });
//  }
//
//  Stream<List<Smoke>> get dailySmokes {
//    return repository.dailySmokesAsStream().map((entities) {
//      return entities.map(Smoke.fromEntity).toList();
//    });
//  }

  Future<void> addNewSmoke(Smoke smoke) => repository.addNewSmoke(smoke.toEntity());

  Future<void> deleteSmoke(String id) => repository.deleteSmoke([id]);
}
