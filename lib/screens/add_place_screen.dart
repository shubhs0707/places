import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Enter Title and image'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                      autofocus: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          Hero(
            tag: 'addButton',
            child: RaisedButton.icon(
              padding: EdgeInsets.all(12),
              onPressed: _savePlace,
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: Text(
                "Add Place",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Theme.of(context).accentColor,
            ),
          )
        ],
      ),
    );
  }
}
