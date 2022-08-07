import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/entry.dart';

class DetailsInfo extends StatelessWidget {
  final Entry entry;
  const DetailsInfo({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            DateFormat('E, MMM d, yyyy').format(entry.date),
            style: Theme.of(context).textTheme.headline5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              entry.imageURL,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "${entry.quantity} items",
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            entry.latitude != null
                ? "Location: (${entry.latitude}, ${entry.latitude})"
                : "Location(Coordinates not available)",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
