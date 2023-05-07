import 'package:equatable/equatable.dart';
import 'package:fire_alert_mobile/src/core/bloc/profile/profile_bloc.dart';

abstract class CommonEvent extends Equatable implements ProfileEvent {
  const CommonEvent();

  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialEvent extends CommonEvent {
  const InitialEvent();
}

class NoInternetConnectionEvent extends CommonEvent {
  const NoInternetConnectionEvent();
}
