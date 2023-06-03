// A widget that displays the picture taken by the user.
import 'dart:io';

import 'package:fire_alert_mobile/src/features/account/profile/presentation/bloc/upload_id/upload_id_bloc.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPreviewPhoto extends StatelessWidget {
  final String imagePath;
  final bool isFrontPhoto;
  final String? imageUrl;

  final bool isPreviewOnly;

  const VerifyPreviewPhoto({
    super.key,
    required this.imagePath,
    this.imageUrl,
    this.isPreviewOnly = false,
    this.isFrontPhoto = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: imageUrl != null
            ? Image.network(imageUrl!)
            : Image.file(
                File(imagePath),
              ),
      ),
      floatingActionButton: isPreviewOnly
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              heroTag: null,
              child: const Icon(Icons.chevron_left),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    if (imageUrl == null) {
                      if (isFrontPhoto) {
                        BlocProvider.of<UploadIdBloc>(context)
                            .add(AddFrontPhotoEvent(imagePath: imagePath));
                      } else {
                        BlocProvider.of<UploadIdBloc>(context)
                            .add(AddBackPhotoEvent(imagePath: imagePath));
                      }
                    }
                    Navigator.pop(context);
                  },
                  heroTag: null,
                  child: const Icon(Icons.check_circle_outline),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (imageUrl == null) ...[
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const TakePictureScreen(),
                        ),
                      );
                    },
                    heroTag: null,
                    child: const Icon(Icons.restart_alt),
                  )
                ]
              ],
            ),
    );
  }
}
