import 'package:equatable/equatable.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  MediaBloc() : super(const InitialState()) {
    on<AddCameraEvent>(_addCameraEvent);
    on<AddVideoEvent>(_addVideoEvent);
  }

  void _addCameraEvent(AddCameraEvent event, Emitter<MediaState> emit) {
    final state = this.state;

    if (state is MediaLoaded) {
      return emit(
          state.copyWith(imagePath: event.path, videoPath: state.videoPath));
    }
    return emit(
      MediaLoaded(imagePath: event.path),
    );
  }

  void _addVideoEvent(AddVideoEvent event, Emitter<MediaState> emit) {
    final state = this.state;

    if (state is MediaLoaded) {
      return emit(
          state.copyWith(imagePath: state.imagePath, videoPath: event.path));
    }
    return emit(
      MediaLoaded(videoPath: event.path),
    );
  }
}
