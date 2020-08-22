import 'dart:async';

import '../models/smoke.dart';
import '../smokes_repository_core/src/reactive_repository.dart';

class SmokesInteractor {
  final ReactiveSmokesRepository repository;

  SmokesInteractor(this.repository);

  Future<void> addNewSmoke(Smoke smoke) => repository.addNewSmoke(smoke.toEntity());

  Future<void> deleteSmoke(String id) => repository.deleteSmoke([id]);
}
