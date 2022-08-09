import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/new_post_screen_arg.dart';
import '../db/entry_dto.dart';
import '../widgets/db_data.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  LocationData? locationData;
  // Initialize Location
  var locationService = Location();

  // Initialize state
  void initState() {
    super.initState();
    retrieveLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to New Post Screen
          goToNewPostScreen(context, NewPostScreenArguments(newPost: newPost));
        },
        backgroundColor: const Color.fromARGB(255, 18, 214, 194),
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        margin: const EdgeInsets.all(10),
        child: const Center(
          child: DbData(),
        ),
      ),
    );
  }

/*
  - Add waste entry to Firestore db
*/
  void newPost(EntryDTO newEntry) {
    FirebaseFirestore.instance.collection('entries').add({
      'date': newEntry.date,
      'quantity': newEntry.quantity,
      'latitude': newEntry.latitude,
      'longitude': newEntry.longitude,
      'imageURL': newEntry.imageURL
    });
  }

  /*
    - Get user's current location
  */
  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }

    locationData = await locationService.getLocation();
    setState(() {});
  }
}

/*
    Navigate to AddEntry Screen
*/
void goToNewPostScreen(BuildContext context, args) {
  Navigator.of(context).pushNamed('newPost', arguments: args);
}
