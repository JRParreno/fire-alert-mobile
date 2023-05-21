import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/preview_photo.dart';
import 'package:flutter/material.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  static const String routeName = 'camera-screen';

  const TakePictureScreen({super.key});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState(); // Obtain a list of the available cameras on the device.

    WidgetsBinding.instance.addPostFrameCallback((_) => setUpCamera());
  }

  Future<void> setUpCamera() async {
    final tempCameras = await availableCameras();

    // To display the current output from the Camera,
    // create a CameraController.
    setState(() {
      _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        tempCameras.first,
        // Define the resolution to use.
        ResolutionPreset.medium,
      );
    });
    _initializeControllerFuture = _controller!.initialize();
    setState(() {
      cameras = tempCameras;
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    if (_controller != null) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller!);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            if (_controller != null) {
              _controller!.setFlashMode(FlashMode.off);

// Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller!.takePicture();

              if (!mounted) return;

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => PreviewPhoto(
                    // Pass the automatically generated path to
                    // the DisplayPictureScreen widget.
                    imagePath: image.path,
                  ),
                ),
              );
            }
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
