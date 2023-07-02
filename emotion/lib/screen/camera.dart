import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class EmotionDetectionPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EmotionDetectionPageState createState() => _EmotionDetectionPageState();
}

class _EmotionDetectionPageState extends State<EmotionDetectionPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isDetecting = false;
  List<dynamic>? _recognitions;

  @override
  void initState() {
    super.initState();

    _loadModel();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras![0], ResolutionPreset.medium);
    await _cameraController?.initialize().then((value) {
      setState(() {
        _cameraController?.startImageStream(_processCameraImage);
      });
    });
  }

  Future<void> _loadModel() async {
    var res = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    print("Model loaded: $res");
  }

  void _processCameraImage(CameraImage image) async {
    if (!_isDetecting) {
      _isDetecting = true;

      await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
      ).then((recognitions) {
        setState(() {
          _recognitions = recognitions;
        });

        _isDetecting = false;
      }).catchError((error) {
        print('Error running model: $error');
        _recognitions = [];
        _isDetecting = false;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_cameraPreview(), _displayEmotion()],
      ),
    );
  }

  Widget _displayEmotion() {
    if (_recognitions == null || _recognitions!.isEmpty) {
      return Container();
    }
    // Assuming the model output is a map with the emotion and its confidence as keys
    String detectedEmotion = _recognitions![0]['label'];
    double confidence = _recognitions![0]['confidence'];

    return Positioned(
      bottom: 20,
      left: 20,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Detected Emotion: $detectedEmotion\nConfidence: ${(confidence * 100).toStringAsFixed(2)}%',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _cameraPreview() {
    if (!_cameraController!.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
      aspectRatio: _cameraController!.value.aspectRatio,
      child: CameraPreview(_cameraController!),
    );
  }
}
