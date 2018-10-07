import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:Social/widgets/common/utils.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isReady = false;
  List<CameraDescription> cameras;
  CameraController controller;

  Future<List<CameraDescription>> getCameras() async {
    return await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    _initCameras();
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

    return Scaffold(
        body: Stack(children: <Widget>[
      CameraPreview(controller),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[Utils.getBranding()]),
    ]));
  }
}
