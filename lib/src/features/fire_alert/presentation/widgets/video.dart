import 'dart:async';

import 'package:camera/camera.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/widgets/preview_video.dart';
import 'package:flutter/material.dart';

// A screen that allows users to take a picture using a given camera.
class TakeVideoScreen extends StatefulWidget {
  static const String routeName = 'video-screen';

  const TakeVideoScreen({super.key});

  @override
  TakeVideoScreenState createState() => TakeVideoScreenState();
}

class TakeVideoScreenState extends State<TakeVideoScreen> {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  Future<void>? _initializeControllerFuture;
  bool _isRecording = false;

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

  void _recordVideo() async {
    if (_isRecording) {
      final file = await _controller!.stopVideoRecording();
      setState(() => _isRecording = false);
      navigateScreen(file.path);
    } else {
      await _controller!.prepareForVideoRecording();
      await _controller!.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  void navigateScreen(String videoPath) {
    // videoPath
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PreviewVideo(
          // Pass the automatically generated path to
          // the DisplayPictureScreen widget.
          filePath: videoPath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CameraPreview(_controller!),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(_isRecording ? Icons.stop : Icons.circle),
                      onPressed: () => _recordVideo(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        heroTag: null,
        child: const Icon(Icons.chevron_left),
      ),
    );
  }
}
