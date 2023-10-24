import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manifest_downloader/core/widgets/progressbar/progress_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String _selectedFolder = '';
  String _manifestUrl = '';

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
              const ProgressBar(),
              ElevatedButton(
                onPressed: () {
                  // Handle button press, use _manifestUrl and _selectedFolder
                },
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
