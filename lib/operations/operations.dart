import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'models/file.dart';

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

  static Future<void> cleanupOutputDir(
      List<FileModel> manifestFiles, String outputDir, List<String> ignoreFolders) async {
    var manifestFileSet = {for (var file in manifestFiles) file.path: file.hash};
    var files = Directory(outputDir).listSync(recursive: true);
    for (var file in files) {
      var relativePath = file.path.substring(outputDir.length + 1);
      if (ignoreFolders.contains(file.parent.path.split('/').last)) {
        continue;
      }
      final hash = await calculateFileHash(file.path);
      final isDiff = manifestFileSet[relativePath] != hash;
      final isAtManifest = manifestFileSet.containsKey(relativePath);
      if (!isAtManifest || isDiff) {
        await file.delete();
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
