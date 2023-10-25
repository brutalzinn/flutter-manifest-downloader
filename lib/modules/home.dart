import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:manifest_downloader/modules/home_logic.dart';
import 'package:manifest_downloader/modules/widgets/custom_elevated_button.dart';

import '../core/widgets/progressbar/progress_bar.dart';
import '../core/widgets/progressbar/progress_bar_controller.dart';
import 'widgets/custom_input_text.dart';

class Home extends StatefulWidget {
  Home({super.key});
  HomeLogic homeLogic = HomeLogic();

  @override
  _ManifestDownloaderState createState() => _ManifestDownloaderState();
}

class _ManifestDownloaderState extends State<Home> {
  String _ignoreFolder = '';
  String _selectedFolder = '/Users/robertopaes/Desktop/testtt';
  String _manifestUrl =
      'http://api-launcher-boberto.boberto.net/modpacks/74b32bbe-8388-4807-bf94-f332f7668857/manifest.json';

  @override
  void initState() {
    widget.homeLogic.progressController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'), // Replace with your background image asset
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
              Text(
                widget.homeLogic.progressController.feedback,
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              ProgressBar(value: widget.homeLogic.progressController.value),
              CustomElevatedButton(
                label: 'Download',
                onPressed: () {
                  widget.homeLogic.startSync(_manifestUrl, _selectedFolder, _ignoreFolder);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
