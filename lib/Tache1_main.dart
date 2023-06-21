import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';


void main() {
  runApp(TextRecognitionApp());
}

class TextRecognitionApp extends StatefulWidget {

  @override
  _TextRecognitionAppState createState() => _TextRecognitionAppState();
}

class _TextRecognitionAppState extends State<TextRecognitionApp> {

  PickedFile? _imageFile;
  List<TextBlock> _textBlocks = [];

  Future<void> _getImageAndRecognizeText(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
      _textBlocks = [];
    });

    if (_imageFile != null) {
      final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(File(_imageFile!.path));
      final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
      final VisionText visionText = await textRecognizer.processImage(visionImage);

      setState(() {
        _textBlocks = visionText.blocks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile == null
                ? Text('No image selected.')
                : Image.file(File(_imageFile!.path)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Take a picture'),
              onPressed: () => _getImageAndRecognizeText(ImageSource.camera),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Select from gallery'),
              onPressed: () => _getImageAndRecognizeText(ImageSource.gallery),
            ),
            SizedBox(height: 20),
            _textBlocks.isEmpty
                ? Text('No text recognized.')
                : Column(
                    children: _textBlocks.map((block) {
                      return Text(block.text ?? '');
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
