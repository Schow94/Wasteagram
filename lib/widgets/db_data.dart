import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/waste_list.dart';

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
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                WasteList(snapshot: snapshot),
              ],
            ),
          );
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
