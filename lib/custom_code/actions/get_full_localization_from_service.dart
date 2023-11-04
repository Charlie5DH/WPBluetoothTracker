// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<String> getFullLocalizationFromService(
  BTDevicesStruct? deviceInfo,
) async {
  // Add your function code here!
  // This action reads from the service related to the localization
  // which has the UUID bae55b96-7d19-458d-970c-50613d801bc9
  // The service has 2 characteristics:
  // - one for the latitude and one for the longitude
  // This action returns the latitude and longitude as a string
  // separated by a comma

  final device = BluetoothDevice.fromId(deviceInfo!.id);
  final services = await device.discoverServices();

  // returns the service with the given UUID
  BluetoothService service = services.firstWhere(
      (element) =>
          element.uuid.toString() == "bae55b96-7d19-458d-970c-50613d801bc9",
      orElse: () => throw Exception("Service not found"));

  // returns the first characteristic of the service, which is the latitude
  BluetoothCharacteristic characteristicLat = service.characteristics.first;
  // returns the second characteristic of the service, which is the longitude
  BluetoothCharacteristic characteristicLng = service.characteristics.last;

  // reads the value from the latitude characteristic
  List<int> valueLat = await characteristicLat.read();
  // reads the value from the longitude characteristic
  List<int> valueLng = await characteristicLng.read();

  String stringValueLat = String.fromCharCodes(valueLat);
  String stringValueLng = String.fromCharCodes(valueLng);

  // remove the last character from the strings and remove everything before the |, if there is a | character
  stringValueLat = stringValueLat.substring(0, stringValueLat.length - 1);
  stringValueLng = stringValueLng.substring(0, stringValueLng.length - 1);
  if (stringValueLat.contains("|")) {
    stringValueLat = stringValueLat.substring(stringValueLat.indexOf("|") + 1);
  }
  if (stringValueLng.contains("|")) {
    stringValueLng = stringValueLng.substring(stringValueLng.indexOf("|") + 1);
  }

  // reduce the number of decimals of the latitude and longitude to 6
  stringValueLat = double.parse(stringValueLat).toStringAsFixed(6);
  stringValueLng = double.parse(stringValueLng).toStringAsFixed(6);

  // returns the latitude and longitude as a string separated by a comma
  return stringValueLat + ", " + stringValueLng;
}
