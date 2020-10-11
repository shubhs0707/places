import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture(int code) async {
    final _picker = ImagePicker();
    final imageFile = code == 0
        ? await _picker.getImage(
            source: ImageSource.camera,
            maxWidth: 600,
            imageQuality: 70,
          )
        : await _picker.getImage(
            source: ImageSource.gallery,
            maxWidth: 600,
            imageQuality: 70,
          );
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 180,
              child: OutlineButton.icon(
                  icon: Icon(Icons.camera),
                  label: Text('Take Picture'),
                  onPressed: () {
                    _takePicture(0);
                  }),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 180,
              child: OutlineButton.icon(
                  icon: Icon(Icons.image),
                  label: Text('From Gallery'),
                  onPressed: () {
                    _takePicture(1);
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
