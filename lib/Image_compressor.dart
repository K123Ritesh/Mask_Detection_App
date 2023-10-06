import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Compressor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageCompressorPage(),
    );
  }
}

class ImageCompressorPage extends StatefulWidget {
  @override
  _ImageCompressorPageState createState() => _ImageCompressorPageState();
}

class _ImageCompressorPageState extends State<ImageCompressorPage> {
  File? _selectedImage;
  double _desiredSize = 1024.0; // Default desired size in KB (as a double)

  Future<void> _selectAndCompressImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Compressor App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ElevatedButton(
              onPressed: _selectAndCompressImage,
              child: Text('Select Image'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Slightly circular
                ),
                primary: Colors.black,
                onPrimary: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            if (_selectedImage != null)
              Column(
                children: [
                  Text(
                      'Desired Compressed Size: ${_desiredSize.toStringAsFixed(1)} KB'),
                  Slider(
                    value: _desiredSize,
                    onChanged: (newValue) {
                      setState(() {
                        _desiredSize = newValue;
                      });
                    },
                    min: 100.0, // Use double values here
                    max: 2048.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompressedImagePage(
                            originalImage: _selectedImage!,
                            desiredSize: _desiredSize,
                          ),
                        ),
                      );
                    },
                    child: Text('Compress'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Slightly circular
                      ),
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class CompressedImagePage extends StatefulWidget {
  final File originalImage;
  final double desiredSize;

  CompressedImagePage({
    required this.originalImage,
    required this.desiredSize,
  });

  @override
  _CompressedImagePageState createState() => _CompressedImagePageState();
}

class _CompressedImagePageState extends State<CompressedImagePage> {
  late File _compressedImage;
  double _originalSizeKB = 0;
  double _compressedSizeKB = 0;

  @override
  void initState() {
    super.initState();
    _compressAndSaveImage();
  }

  Future<void> _compressAndSaveImage() async {
    Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
      widget.originalImage.path,
      quality: 80, // Adjust quality as needed
      minHeight: 800, // Set minimum dimensions to maintain aspect ratio
      minWidth: 800,
    );

    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(widget.originalImage.path);
    final compressedFilePath = join(directory.path, 'compressed_$fileName');

    _compressedImage = File(compressedFilePath);
    await _compressedImage.writeAsBytes(compressedBytes!);

    setState(() {
      _originalSizeKB = widget.originalImage.lengthSync() / 1024;
      _compressedSizeKB = _compressedImage.lengthSync() / 1024;
    });
  }

  Future<void> _downloadCompressedImage() async {
    final bytes = await _compressedImage.readAsBytes();
    final directory = await getDownloadsDirectory();
    final fileName = basename(_compressedImage.path);
    final downloadFilePath = join(directory!.path, fileName);

    File downloadFile = File(downloadFilePath);
    await downloadFile.writeAsBytes(bytes);

    // Show download confirmation
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text('Image downloaded.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compressed Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(
              widget.originalImage,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Original Size: ${_originalSizeKB.toStringAsFixed(1)} KB'),
            Text('Compressed Size: ${_compressedSizeKB.toStringAsFixed(1)} KB'),
            ElevatedButton(
              onPressed: _downloadCompressedImage,
              child: Text('Download'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Slightly circular
                ),
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Compress Again'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Slightly circular
                ),
                primary: Colors.white,
                onPrimary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
