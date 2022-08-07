import 'package:flutter/material.dart';

import 'screens/list_screen.dart';
import 'screens/new_post_screen.dart';
import 'screens/details_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => ListScreen(),
        'newPost': (context) => const NewPostScreen(),
        'details': (context) => DetailsScreen(),
      },
    );
  }
}
