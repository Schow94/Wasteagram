import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/entry.dart';
import '../models/details_screen_arg.dart';

class ListItem extends StatelessWidget {
  var post;
  var goToDetailsScreen;

  ListItem({Key? key, required this.post, required this.goToDetailsScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      onTapHint: 'Create new post',
      child: GestureDetector(
          child: Card(
            child: ListTile(
              title: Text(
                DateFormat('EEEE, MMMM d, yyyy').format(
                  post['date'].toDate(),
                ),
              ),
              trailing: Text(
                post['quantity']!.toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          onTap: () {
            Entry newEntry = Entry(
              imageURL: post['imageURL'],
              date: post['date'].toDate(),
              latitude: post['latitude'],
              longitude: post['longitude'],
              quantity: post['quantity'],
            );

            goToDetailsScreen(
              context,
              DetailsScreenArguments(entry: newEntry),
            );
          }),
    );
  }
}
