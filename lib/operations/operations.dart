import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:manifest_downloader/core/progress/progress.dart';
import 'package:manifest_downloader/core/progress/progress_bar_controller.dart';
import 'models/file.dart';

typedef CallbackProgress = void Function(Progress);

class Operations {
  static Future<List<FileModel>> readManifestFiles(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return List<FileModel>.from(list.map((model) => FileModel.fromJson(model)));
    } else {
      throw Exception('Failed to fetch manifest');
    }
  }

  static Future<void> downloadFile(FileModel file, String outputDir) async {
    var outFilePath = '$outputDir/${file.path}';
    var dirName = File(outFilePath).parent.path;
    await Directory(dirName).create(recursive: true);
    var outFile = File(outFilePath).openWrite();
    var response = await http.get(Uri.parse(file.url));
    if (response.statusCode == 200) {
      var controller = StreamController<List<int>>();
      controller.sink.add(response.bodyBytes);
      controller.stream.pipe(outFile);
      await controller.close();
      await outFile.close();
    } else {
      throw Exception('Failed to download file: ${file.name}');
    }
  }

  static Future<void> cleanupOutputDir(List<FileModel> manifestFiles, String outputDir, List<String> ignoreFolders,
      CallbackProgress callbackAction) async {
    var files = Directory(outputDir).listSync(recursive: true);
    var manifestFileSet = {for (var file in manifestFiles) file.path: file.hash};
    final progress = Progress();
    for (var file in files) {
      progress.setFeedback("verify ${file.parent.path}");
      callbackAction(progress);
      var relativePath = file.path.substring(outputDir.length + 1);
      final isToIgnore = ignoreFolders.contains(file.parent.path);
      if (isToIgnore || file is Directory) {
        progress.setFeedback("ignore ${file.parent.path}");
        callbackAction(progress);
        continue;
      }
      final hash = await calculateFileHash(file.path);
      final isDiff = manifestFileSet[relativePath] != hash;
      final isAtManifest = manifestFileSet.containsKey(relativePath);
      if (!isAtManifest || isDiff) {
        await file.delete();
        progress.setFeedback("delete ${file.parent.path}");
        callbackAction(progress);
      }
    }
  }

  static Future<String> calculateFileHash(String filePath) async {
    var file = File(filePath);
    var contents = await file.readAsBytes();
    var digest = sha1.convert(contents);
    return digest.toString();
  }
}
