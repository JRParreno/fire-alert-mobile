import 'package:equatable/equatable.dart';
import 'package:fire_alert_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:fire_alert_mobile/src/features/account/profile/presentation/bloc/upload_id/upload_id_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/fire_alert_bloc/fire_alert_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/media_bloc/media_bloc.dart';
import 'package:fire_alert_mobile/src/features/home/data/bloc/home_carousel/home_carousel_bloc.dart';

abstract class CommonState extends Equatable
    implements
        ProfileState,
        MediaState,
        FireAlertState,
        UploadIdState,
        HomeCarouselState {
  const CommonState();
  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialState extends CommonState {
  const InitialState();
}

// loading state for all blocs
class LoadingState extends CommonState {
  const LoadingState();
}

class ErrorState extends CommonState {
  final String error;
  const ErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class NoInternetConnectionState extends CommonState {
  const NoInternetConnectionState();
}

class ServerExceptionState extends CommonState {
  final String error;
  const ServerExceptionState(this.error);

  @override
  List<Object> get props => [error];
}

class TimeoutExceptionState extends CommonState {
  final String error;
  const TimeoutExceptionState(this.error);

  @override
  List<Object> get props => [error];
}
