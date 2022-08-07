import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/list_item.dart';

class WasteList extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot> snapshot;

  const WasteList({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          var post = snapshot.data!.docs[index];
          return ListItem(post: post, goToDetailsScreen: goToDetailsScreen);
        },
      ),
    );
  }
}

/*
    Navigate to Details Screen
  */
void goToDetailsScreen(BuildContext context, args) {
  Navigator.of(context).pushNamed('details', arguments: args);
}
