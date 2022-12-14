import 'package:flutter/material.dart';

import 'screens/list_screen.dart';
import 'screens/new_post_screen.dart';
import 'screens/details_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => const ListScreen(),
        'newPost': (context) => const NewPostScreen(),
        'details': (context) => const DetailsScreen(),
      },
    );
  }
}
