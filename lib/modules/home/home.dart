import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manifest_downloader/core/managers/config/models/config_model.dart';
import 'package:manifest_downloader/core/resources.dart';
import 'package:manifest_downloader/core/ui/widgets/progressbar/progress_bar.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_input_text.dart';
import 'logic/home_logic.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({super.key});
  HomeLogic homeLogic = HomeLogic();

  @override
  _ManifestDownloaderState createState() => _ManifestDownloaderState();
}

class _ManifestDownloaderState extends State<Home> {
  String _ignoreFolder = '';
  String _selectedFolder = '';
  String _manifestUrl = '';

  @override
  void initState() {
    widget.homeLogic.progressController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var config = await widget.homeLogic.loadConfig();

      setState(() {
        _manifestUrl = config.manifestURL;
        _selectedFolder = config.outputDir;
        _ignoreFolder = config.ignoreFolders;
      });
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
                label: 'Enter Manifest URL:',
                onChanged: (value) {
                  setState(() {
                    _manifestUrl = value;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              CustomInputText(
                label: 'Ignore folders:',
                onChanged: (value) {
                  setState(() {
                    _ignoreFolder = value;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                  onPressed: () async {
                    var folder = await FilePicker.platform.getDirectoryPath();
                    if (folder != null) {
                      setState(() {
                        _selectedFolder = folder;
                      });
                    }
                  },
                  label: 'Select Folder'),
              const SizedBox(height: 20.0),
              Text(
                'Output Folder: $_selectedFolder',
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              Text(
                widget.homeLogic.progressController.progress.feedback ?? "",
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              ProgressBar(
                  value: widget.homeLogic.progressController.progress.value),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                label: 'Download',
                onPressed: () {
                  widget.homeLogic
                      .startSync(_manifestUrl, _selectedFolder, _ignoreFolder);
                },
              ),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                label: 'Save config',
                onPressed: () {
                  final config = ConfigModel(
                      manifestURL: _manifestUrl,
                      outputDir: _selectedFolder,
                      ignoreFolders: _ignoreFolder);
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
