import 'package:flutter/material.dart';
import 'camera.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:ui';
import 'home_screen.dart';


class Recognize {

  bool _isDetecting = false;

  VisionText _textScanResults;

  CameraLensDirection _direction = CameraLensDirection.back;

  CameraController _camera;

  final TextRecognizer _textRecognizer =
  FirebaseVision.instance.textRecognizer();

  @override
  void initState() {
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description =
    await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.high,
    );

    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;
      _isDetecting = true;
      ScannerUtils.detect(
        image: image,
        detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then(
            (results) {
          if (results != null) {
            _textScanResults = results;
          }
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Future<VisionText> Function(FirebaseVisionImage image) _getDetectionMethod() {
    return _textRecognizer.processImage;
  }
}