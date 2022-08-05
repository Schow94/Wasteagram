import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/entry.dart';
import '../models/new_post_screen_arg.dart';
import '../db/entry_dto.dart';
import '../models/details_screen_arg.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // locationData is null for some reason
  LocationData? locationData;
  var locationService = Location();

  List<Entry> entries = [];

  void initState() {
    super.initState();
    retrieveLocation();
    // loadEntries();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToNewPostScreen(
            context,
            NewPostScreenArguments(newPost: newPost),
          );
        },
        backgroundColor: const Color.fromARGB(255, 18, 214, 194),
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Center(
          child: EntriesList(entries: entries),
        ),
      ),
    );
  }

  // /*
  //   - Add new Waste post
  // */
  // void newPost(EntryDTO newEntry) {
  //   Entry entry = Entry(
  //     image: newEntry.image,
  //     date: newEntry.date,
  //     longtitude: newEntry.longtitude,
  //     latitude: newEntry.latitude,
  //     items: newEntry.items,
  //   );

  //   setState(() {
  //     entries.add(entry);
  //   });
  // }

/*
  - Add entry to db
*/
  void newPost(EntryDTO newEntry) {
    FirebaseFirestore.instance.collection('entries').add({
      'date': newEntry.date,
      'items': newEntry.items,
      'latitude': newEntry.latitude,
      'longitude': newEntry.longtitude,
      'image': newEntry.image

      // Want to store image in firestore storage 1st & store url in firestore
      // 'image': newEntry.image
    });
  }
}

/*
    Navigate to AddEntry Screen
  */
void goToNewPostScreen(BuildContext context, args) {
  Navigator.of(context).pushNamed('newPost', arguments: args);
}

/*
    Navigate to Details Screen
  */
void goToDetailsScreen(BuildContext context, args) {
  Navigator.of(context).pushNamed('details', arguments: args);
}

class EntriesList extends StatelessWidget {
  List<Entry> entries;

  EntriesList({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DbData();
  }
}

class DbData extends StatelessWidget {
  const DbData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('entries')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData &&
            snapshot.data!.docs != null &&
            snapshot.data!.docs.length > 0) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              return GestureDetector(
                  child: Card(
                    child: ListTile(
                      title: Text(
                        DateFormat('yyyy-MM-dd').format(
                          post['date'].toDate(),
                        ),
                      ),
                      leading: Text(
                        post['items'].toString(),
                      ),
                    ),
                  ),
                  onTap: () {
                    Entry newEntry = Entry(
                      image: post['image'],
                      date: post['date'].toDate(),
                      latitude: post['latitude'],
                      longtitude: post['longitude'],
                      items: post['items'],
                    );

                    goToDetailsScreen(
                      context,
                      DetailsScreenArguments(entry: newEntry),
                    );
                  });
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// /*
//   - Add entry to db
// */
// void addEntryTodB() {
//   print('Adding to db');

//   FirebaseFirestore.instance.collection('entries').add({
//     'date': DateTime.now(),
//     'items': 0,
//     'latitude': 0,
//     'longitude': 0,
//   });
// }
