import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.native_code_example/date');
  String _currentDate = "Unknown";

  File? _image;

  // Метод для отримання поточної дати з нативного коду
  Future<void> _getCurrentDate() async {
    try {
      final String date = await platform.invokeMethod('getDate');
      setState(() {
        _currentDate = date;
      });
    } on PlatformException catch (e) {
      setState(() {
        _currentDate = "Failed to get date: '${e.message}'.";
      });
    }
  }

  // Метод для вибору фотографії
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Native Code Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Кнопка для отримання поточної дати
            ElevatedButton(
              onPressed: _getCurrentDate,
              child: Text("Get Current Date"),
            ),
            Text("Current Date: $_currentDate"),

            // Кнопка для вибору фото
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Take Photo"),
            ),
            _image == null
                ? Text("No image selected.")
                : Image.file(_image!),
          ],
        ),
      ),
    );
  }
}
