import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/entry.dart';
import '../models/details_screen_arg.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenargs =
        ModalRoute.of(context)?.settings.arguments as DetailsScreenArguments;
    final Entry entry = screenargs.entry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              DateFormat('yyyy-MM-dd').format(entry.date),
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
      ),
    );
  }
}

/*
    Navigate to AddEntry Screen
  */
void goToDetailsScreen(BuildContext context) {
  Navigator.of(context).pushNamed('details');
}
