import 'dart:async';
import 'package:http/http.dart';

class CloudinaryUploader {
  final Client httpClient = Client();
  static final CloudinaryUploader _instance =
      new CloudinaryUploader._internal();

  factory CloudinaryUploader() {
    return _instance;
  }

  CloudinaryUploader._internal();

  Future<StreamedResponse> upload(String filePath) async {
    MultipartFile file = await MultipartFile.fromPath('file', filePath);
    Uri uri =
        Uri.parse('https://api.cloudinary.com/v1_1/dqdoqnnw3/image/upload');
    MultipartRequest request = MultipartRequest('POST', uri);
    request.fields['upload_preset'] = 'kw3fnskc';
    request.files.add(file);
    return request.send();
  }
}
