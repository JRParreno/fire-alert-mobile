import 'package:equatable/equatable.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_event.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_id_event.dart';
part 'upload_id_state.dart';

class UploadIdBloc extends Bloc<UploadIdEvent, UploadIdState> {
  UploadIdBloc() : super(const InitialState()) {
    on<InitialEvent>(_initialEvent);
    on<AddFrontPhotoEvent>(_addFrontPhotoEvent);
    on<AddBackPhotoEvent>(_addBackPhotoEvent);
  }

  void _initialEvent(InitialEvent event, Emitter<UploadIdState> emit) {
    return emit(const InitialState());
  }

  void _addFrontPhotoEvent(
      AddFrontPhotoEvent event, Emitter<UploadIdState> emit) {
    final state = this.state;

    return emit(
      UploadIdLoaded(
          frontPhotoPath: event.imagePath,
          backPhotoPath: state is UploadIdLoaded ? state.backPhotoPath : null),
    );
  }

  void _addBackPhotoEvent(
      AddBackPhotoEvent event, Emitter<UploadIdState> emit) {
    final state = this.state;

    return emit(
      UploadIdLoaded(
          frontPhotoPath: state is UploadIdLoaded ? state.frontPhotoPath : null,
          backPhotoPath: event.imagePath),
    );
  }
}
