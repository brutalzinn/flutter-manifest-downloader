import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../core/widgets/progressbar/progress_bar.dart';
import '../core/widgets/progressbar/progress_bar_controller.dart';

class Home extends StatefulWidget {
  Home({super.key});
  ProgressBarController progressBarController = ProgressBarController();

  @override
  _ManifestDownloaderState createState() => _ManifestDownloaderState();
}

class _ManifestDownloaderState extends State<Home> {
  String _selectedFolder = '';
  String _manifestUrl = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/background.jpg'), // Replace with your background image asset
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Enter Manifest URL:',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _manifestUrl = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.5),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  var folder = await FilePicker.platform.getDirectoryPath();
                  if (folder != null) {
                    setState(() {
                      _selectedFolder = folder;
                    });
                  }
                },
                child: const Text(
                  'Select Folder',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Selected Folder: $_selectedFolder',
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              ProgressBar(progressBarController: widget.progressBarController),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Download',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
