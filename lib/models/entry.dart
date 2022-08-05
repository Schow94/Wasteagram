/*
  - Waste Entry
*/

class Entry {
  final String image;
  DateTime date = DateTime.now();
  final double? latitude;
  final double? longtitude;
  final int items;

  Entry({
    required this.image,
    required this.date,
    required this.latitude,
    required this.longtitude,
    required this.items,
  });
}

// 37.71688714797971, -122.46683295141479