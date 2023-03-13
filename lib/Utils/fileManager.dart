import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';

late String _localPath;
late bool _permissionReady;

class FileManager {
  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);

    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    // if (platform == TargetPlatform.android) {
    //   return "/sdcard/download/";
    // } else {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path + Platform.pathSeparator + 'Download';
    //}
  }

  _askPermisionFiles() async {
    // if (platform == TargetPlatform.android) {
    //   final status = await Permission.storage.status;
    //   if (status != PermissionStatus.granted) {
    //     final result = await Permission.storage.request();
    //     if (result == PermissionStatus.granted) {
    //       return true;
    //     }
    //   } else {
    //     return true;
    //   }
    // } else {
    return true;
    //   }
    //   return false;
    // }
  }

  getLoclPath() async {
    var localPath = await _findLocalPath();
    return localPath!;
  }

  saveWhatsappFile(fileurl) async {
    //output:  /storage/emulated/0/Download/banner.png
    var uuid = Uuid().v1();
    _permissionReady = await _askPermisionFiles();
    if (_permissionReady) {
      await _prepareSaveDir();
      print("Downloading");
      try {
        await Dio().download(fileurl, _localPath + "/" + "$uuid.jpg");
        print("Download Completed.");
      } catch (e) {
        print("Download Failed.\n\n" + e.toString());
      }
    }

    return "$uuid.jpg";
  }
}
