import 'dart:convert';
import 'dart:io';

class Config {
  String manifestURL;
  String outputDir;
  String ignoreFolders;

  Config({
    required this.manifestURL,
    required this.outputDir,
    required this.ignoreFolders,
  });

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      manifestURL: json['manifest_url'],
      outputDir: json['output_dir'],
      ignoreFolders: json['ignore_folders'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manifest_url': manifestURL,
      'output_dir': outputDir,
      'ignore_folders': ignoreFolders,
    };
  }

  static const String configFilePath = 'config.json';

  static Future<Config> loadConfig() async {
    try {
      File file = File(configFilePath);
      String contents = await file.readAsString();
      Map<String, dynamic> jsonData = json.decode(contents);
      return Config.fromJson(jsonData);
    } catch (e) {
      // Handle file not found error or JSON decoding error
      return Config(manifestURL: '', outputDir: '', ignoreFolders: '');
    }
  }

  Future<void> saveConfig() async {
    File file = File(configFilePath);
    await file.writeAsString(jsonEncode(this));
  }
}
