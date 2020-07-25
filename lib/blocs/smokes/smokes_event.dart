import 'package:equatable/equatable.dart';

import '../../models/smoke.dart';

abstract class SmokesEvent extends Equatable {
  const SmokesEvent();

  @override
  List<Object> get props => [];
}

class AddSmoke extends SmokesEvent {
  final Smoke smoke;

  const AddSmoke(this.smoke);
  @override

  List<Object> get props => [smoke];

  @override
  String toString() => 'AddSmoke { smoke: $smoke }';
}

class LoadSmokes extends SmokesEvent {}

class UpdateSmoke extends SmokesEvent {
  final Smoke updatedSmoke;

  const UpdateSmoke(this.updatedSmoke);

  @override
  List<Object> get props => [updatedSmoke];

  @override
  String toString() => 'UpdateSmoke { updatedSmoke: $updatedSmoke }';
}

class DeleteSmoke extends SmokesEvent {
  final Smoke smoke;

  const DeleteSmoke(this.smoke);

  @override
  List<Object> get props => [smoke];

  @override
  String toString() => 'DeleteSmoke { smoke: $smoke }';
}