part of 'fire_alert_bloc.dart';

abstract class FireAlertEvent extends Equatable {
  const FireAlertEvent();

  @override
  List<Object> get props => [];
}

class OnFetchFireAlert extends FireAlertEvent {}
