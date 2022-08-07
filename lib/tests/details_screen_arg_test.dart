import 'package:test/test.dart';

import '../models/entry.dart';
import '../models/details_screen_arg.dart';

void main() {
  test('Post created from Map should have appropriate values', () {
    final Entry waste_entry = Entry(
      imageURL:
          '/Users/schow/Library/Developer/CoreSimulator/Devices/BFD526AB-A853-4F55-95E2-3724A99C3D19/data/Containers/Data/Application/00695FE5-CA74-46C0-A608-E62A8535959B/tmp/image_picker_32756AE8-F50E-4850-9720-B189DAD2F2C0-35489-000000C72591676E.jpg',
      date: DateTime.now(),
      latitude: 2.0,
      longitude: 1.0,
      quantity: 33,
    );

    final entry = DetailsScreenArguments(
      entry: waste_entry,
    );

    expect(entry.entry, waste_entry);
  });
}
