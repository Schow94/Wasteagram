import 'package:flutter/material.dart';

import '../models/entry.dart';
import '../models/details_screen_arg.dart';
import '../widgets/details_info.dart';

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
      body: DetailsInfo(entry: entry),
    );
  }
}
