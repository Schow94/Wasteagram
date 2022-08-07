import 'package:test/test.dart';

import '../models/entry.dart';

void main() {
  test('Post created from Map should have appropriate values', () {
    const imageURL =
        '/Users/schow/Library/Developer/CoreSimulator/Devices/BFD526AB-A853-4F55-95E2-3724A99C3D19/data/Containers/Data/Application/00695FE5-CA74-46C0-A608-E62A8535959B/tmp/image_picker_32756AE8-F50E-4850-9720-B189DAD2F2C0-35489-000000C72591676E.jpg';
    final date = DateTime.now();
    final latitude = 2.0;
    final longitude = 1.0;
    final quantity = 33;

    final waste_entry = Entry(
      date: date,
      imageURL: imageURL,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude,
    );

    expect(waste_entry.date, date);
    expect(waste_entry.imageURL, imageURL);
    expect(waste_entry.quantity, quantity);
    expect(waste_entry.latitude, latitude);
    expect(waste_entry.longitude, longitude);
  });
}
