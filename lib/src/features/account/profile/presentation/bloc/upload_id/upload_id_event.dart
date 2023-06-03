part of 'upload_id_bloc.dart';

abstract class UploadIdEvent extends Equatable {
  const UploadIdEvent();

  @override
  List<Object> get props => [];
}

class AddFrontPhotoEvent extends UploadIdEvent {
  final String imagePath;

  const AddFrontPhotoEvent({
    required this.imagePath,
  });

  @override
  List<Object> get props => [
        imagePath,
      ];
}

class AddBackPhotoEvent extends UploadIdEvent {
  final String imagePath;

  const AddBackPhotoEvent({
    required this.imagePath,
  });

  @override
  List<Object> get props => [
        imagePath,
      ];
}
