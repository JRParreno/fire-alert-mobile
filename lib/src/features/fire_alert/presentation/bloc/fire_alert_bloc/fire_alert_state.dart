// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'fire_alert_bloc.dart';

abstract class FireAlertState extends Equatable {
  const FireAlertState();

  @override
  List<Object?> get props => [];
}

class FireAlertLoaded extends FireAlertState {
  final FireAlert fireAlert;

  const FireAlertLoaded(this.fireAlert);

  FireAlertLoaded copyWith({
    FireAlert? fireAlert,
  }) {
    return FireAlertLoaded(
      fireAlert ?? this.fireAlert,
    );
  }

  @override
  List<Object?> get props => [
        fireAlert,
      ];
}
