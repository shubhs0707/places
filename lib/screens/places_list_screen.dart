import 'package:flutter/material.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text("Add Place"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
