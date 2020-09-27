import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../models/smoke.dart';
import '../../smokes_repository_core/src/reactive_repository.dart';
import 'smokes_event.dart';
import 'smokes_state.dart';

class SmokesBloc extends Bloc<SmokesEvent, SmokesState> {
  final ReactiveSmokesRepository smokesRepository;

  SmokesBloc({@required this.smokesRepository});

  @override
  SmokesState get initialState => SmokesLoading();

  @override
  Stream<SmokesState> mapEventToState(SmokesEvent event) async* {
    debugPrint("SmokesBloc mapEventToState event = " + event.toString());
    if (event is LoadSmokes) {
      yield* _mapLoadSmokesToState();
    } else if (event is AddSmoke) {
      yield* _mapAddSmokeToState(event);
    } else if (event is UpdateSmoke) {
//      yield* _mapUpdateSmokeToState(event);
    } else if (event is DeleteSmoke) {
      yield* _mapDeleteSmokeToState(event);
    }
  }

  Stream<SmokesState> _mapLoadSmokesToState() async* {
    try {
      final monthlySmokes = await smokesRepository.monthlySmokes();
      final dailySmokes = await smokesRepository.dailySmokes();
      final smokes = await smokesRepository.smokes();
      yield SmokesLoaded(
        smokes.map(Smoke.fromEntity).toList(),
        monthlySmokes.map(Smoke.fromEntity).toList(),
        dailySmokes.map(Smoke.fromEntity).toList(),
      );
    } catch (e) {
      yield SmokesNotLoaded();
    }
  }

  Stream<SmokesState> _mapAddSmokeToState(AddSmoke event) async* {
    if (state is SmokesLoaded) {
      yield SmokesLoaded(List<Smoke>.from((state as SmokesLoaded).totalSmokes)..insert(0, event.smoke), List<Smoke>.from((state as SmokesLoaded).monthlySmokes)..insert(0, event.smoke), List<Smoke>.from((state as SmokesLoaded).dailySmokes)..insert(0, event.smoke));
      await _addSmoke(event.smoke);
    }
  }

  Stream<SmokesState> _mapDeleteSmokeToState(DeleteSmoke event) async* {
    if (state is SmokesLoaded) {
      yield SmokesLoaded(
          (state as SmokesLoaded).monthlySmokes.where((smoke) => smoke.id != event.smoke.id).toList(), (state as SmokesLoaded).dailySmokes.where((smoke) => smoke.id != event.smoke.id).toList());
      await _deleteSmoke(event.smoke);
    }
  }

  Future _deleteSmoke(Smoke smoke) {
    return smokesRepository.deleteSmoke([smoke.id]);
  }

  Future _addSmoke(Smoke smoke) {
    return smokesRepository.addNewSmoke(smoke.toEntity());
  }
}
