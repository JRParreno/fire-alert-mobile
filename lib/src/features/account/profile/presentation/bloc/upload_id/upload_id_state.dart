part of 'upload_id_bloc.dart';

abstract class UploadIdState extends Equatable {
  const UploadIdState();

  @override
  List<Object?> get props => [];
}

class UploadIdLoaded extends UploadIdState {
  final String? frontPhotoPath;
  final String? backPhotoPath;

  const UploadIdLoaded({
    this.frontPhotoPath,
    this.backPhotoPath,
  });

  @override
  List<Object?> get props => [
        frontPhotoPath,
        backPhotoPath,
      ];
}
