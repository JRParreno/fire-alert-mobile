import 'package:equatable/equatable.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_event.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_state.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/models/fire_alert.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/repositories/fire_alert_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fire_alert_event.dart';
part 'fire_alert_state.dart';

class FireAlertBloc extends Bloc<FireAlertEvent, FireAlertState> {
  FireAlertBloc() : super(const InitialState()) {
    on<OnFetchFireAlert>(_onFetchFireAlert);
    on<InitialEvent>(_setInitialState);
  }

  void _setInitialState(InitialEvent event, Emitter<FireAlertState> emit) {
    return emit(const InitialState());
  }

  void _onFetchFireAlert(
      OnFetchFireAlert event, Emitter<FireAlertState> emit) async {
    await FireAlertRepositoryImpl().fetchCurrentFireAlert().then((value) {
      if (value != null) {
        return emit(FireAlertLoaded(value));
      }
      return emit(const InitialState());
    });
  }
}
