/*
  Student: Stephen Chow
  Email: chowst@oregonstate.edu
  Project: 5 - Wasteagram
  Last Updated: 8/5/22
*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}
