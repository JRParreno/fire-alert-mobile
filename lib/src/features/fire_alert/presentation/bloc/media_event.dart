part of 'media_bloc.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();

  @override
  List<Object> get props => [];
}

class AddCameraEvent extends MediaEvent {
  final String path;

  const AddCameraEvent(this.path);
}

class AddVideoEvent extends MediaEvent {
  final String path;

  const AddVideoEvent(this.path);
}
