/*
  - Data Transfer Object for Entry
*/
import 'dart:io';

// import 'package:image_picker/image_picker.dart';

class EntryDTO {
  String image =
      '/Users/schow/Library/Developer/CoreSimulator/Devices/BFD526AB-A853-4F55-95E2-3724A99C3D19/data/Containers/Data/Application/00695FE5-CA74-46C0-A608-E62A8535959B/tmp/image_picker_32756AE8-F50E-4850-9720-B189DAD2F2C0-35489-000000C72591676E.jpg';
  DateTime date = DateTime.now();
  double latitude = 37.71688714797971;
  double longtitude = -122.46683295141479;
  int items = 0;

  String toString() =>
      'Image: $image, Date: $date, Latitude: $latitude, Longitude: $longtitude, Items: $items';
}


// 37.71688714797971, -122.46683295141479