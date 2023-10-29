import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manifest_downloader/core/managers/config/models/config_model.dart';
import 'package:manifest_downloader/core/resources.dart';
import 'package:manifest_downloader/core/ui/widgets/custom_elevated_button.dart';
import 'package:manifest_downloader/core/ui/widgets/custom_input_text.dart';
import 'package:manifest_downloader/core/ui/widgets/custom_progress_bar.dart';

import 'logic/home_logic.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({super.key});
  HomeLogic homeLogic = HomeLogic();

  @override
  _ManifestDownloaderState createState() => _ManifestDownloaderState();
}

class _ManifestDownloaderState extends State<Home> {
  TextEditingController manifestUrlController = TextEditingController();
  TextEditingController ignoreFolderController = TextEditingController();
  TextEditingController outputDirController = TextEditingController();

  @override
  void initState() {
    widget.homeLogic.progressController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var config = await widget.homeLogic.loadConfig();
      outputDirController.text = config.outputDir;
      manifestUrlController.text = config.manifestURL;
      ignoreFolderController.text = config.ignoreFolders;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Resources.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomInputText(
                controller: manifestUrlController,
                label: 'Enter Manifest URL:',
                onChanged: (value) {
                  manifestUrlController.text = value;
                },
              ),
              const SizedBox(height: 20.0),
              CustomInputText(
                controller: ignoreFolderController,
                label: 'Ignore folders:',
                onChanged: (value) {
                  ignoreFolderController.text = value;
                },
              ),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                  onPressed: () async {
                    var folder = await FilePicker.platform.getDirectoryPath();
                    if (folder != null) {
                      outputDirController.text = folder;
                    }
                  },
                  label: 'Select your .minecraft'),
              const SizedBox(height: 20.0),
              Text(
                'Client Folder: ${outputDirController.text}',
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              Text(
                widget.homeLogic.progressController.progress.feedback ?? "",
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              CustomProgressBar(
                  value: widget.homeLogic.progressController.progress.value),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                label: 'Download',
                onPressed: () {
                  widget.homeLogic.startSync(manifestUrlController.text,
                      outputDirController.text, ignoreFolderController.text);
                },
              ),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                label: 'Save config',
                onPressed: () {
                  final config = ConfigModel(
                      manifestURL: manifestUrlController.text,
                      outputDir: outputDirController.text,
                      ignoreFolders: ignoreFolderController.text);
                  widget.homeLogic.saveConfig(config);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
