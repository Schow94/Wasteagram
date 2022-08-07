/*
  - Waste Entry
*/

class Entry {
  final String imageURL;
  DateTime date = DateTime.now();
  final double? latitude;
  final double? longitude;
  final int quantity;

  Entry({
    required this.imageURL,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.quantity,
  });
}
