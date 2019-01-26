import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:Social/services/cloudinary.dart';
import 'package:http/http.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isReady = false;
  String _dirPath;
  List<CameraDescription> cameras;
  CameraController controller;
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  CloudinaryUploader _uploader = new CloudinaryUploader();

  Future<List<CameraDescription>> getCameras() async {
    return await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    _initDirectory();
    _initCameras();
  }

  Future<void> _initDirectory() async {
    Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);

    setState(() {
      _dirPath = dirPath;
    });
  }

  Future<void> _initCameras() async {
    try {
      cameras = await getCameras();
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (error) {
      print('CameraException throw' + error.toString());
    }

    setState(() {
      _isReady = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  _getBody() {
    if (!_isReady) {
      return Container();
    }

    return Stack(children: <Widget>[
      CameraPreview(controller),
      
      Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FlatButton(
							color: Color.fromARGB(255, 255, 255, 255),
                onPressed: () async {
                  //String response = await _takePicture();
									Navigator.pushNamed(context, 'share');
                },
                child: Text('SNAP'))
          ]),
    ]);
  }

  Future<String> _takePicture() async {
    final String filePath = '$_dirPath/${timestamp()}.jpg';
    await controller.takePicture(filePath);
    StreamedResponse response = await _uploader.upload(filePath);
    File(filePath).deleteSync();

    return Response.fromStream(response).then((response) {
      return response.body;
    });
  }
}
