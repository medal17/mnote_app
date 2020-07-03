import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async' ;
import 'camera.dart';


CameraController _camera;
CameraLensDirection direction;

class StartCamera {

  void _initializeCamera() async {
    final CameraDescription description = await ScannerUtils.getCamera(
        direction);

    _camera = CameraController(
      description,
      ResolutionPreset.high,
    );

    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      // Here we will scan the text from the image
      // which we are getting from the camera.

    });
  }

}