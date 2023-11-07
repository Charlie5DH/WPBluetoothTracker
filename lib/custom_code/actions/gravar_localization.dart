// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future gravarLocalization(
  BTDevicesStruct? deviceInfo,
  String? serviceUUID,
  String? latitude,
  String? longitude,
  String? localization,
  bool? fullLocalization,
) async {
  // Add your function code here!
  // This action writes the latitude and the longitude to the service related to the localization
  // which has the UUID bae55b96-7d19-458d-970c-50613d801bc9
  // The service has 2 characteristics:
  // - one for the latitude and one for the longitude
  // if the fullLocalization parameter is true, it takes the lat and lng from
  // the localization parameter, otherwise it takes the lat and lng from the

  if (serviceUUID == null) {
    serviceUUID = "bae55b96-7d19-458d-970c-50613d801bc9";
  }

  String timestampServiceUUID = "a617811d-d2a0-4155-923e-de09de01849c";

  if (fullLocalization == true) {
    // the localization string has the format: LatLng(lat: latitude, lng: longitude)
    // so we need to take the lat and lng from the string, removing the rest

    // remove the first 7 characters from the string
    localization = localization!.substring(7);
    // remove the last 1 character from the string
    localization = localization.substring(0, localization.length - 1);
    // split the string by the comma
    List<String> latLng = localization.split(",");
    // take the latitude from the first element of the list
    latitude = latLng[0];
    // take the longitude from the second element of the list
    longitude = latLng[1];

    // remove the lat: and lng: from the strings
    latitude = latitude.substring(5);
    longitude = longitude.substring(5);

    // reduce the number of decimals of the latitude and longitude to 6
    latitude = double.parse(latitude).toStringAsFixed(6);
    longitude = double.parse(longitude).toStringAsFixed(6);
  } else {
    // reduce the number of decimals of the latitude and longitude to 6
    latitude = double.parse(latitude!).toStringAsFixed(6);
    longitude = double.parse(longitude!).toStringAsFixed(6);
  }

  final device = BluetoothDevice.fromId(deviceInfo!.id);
  final services = await device.discoverServices();

  // returns the service with the given UUID
  BluetoothService service = services.firstWhere(
      (element) => element.uuid.toString() == serviceUUID,
      orElse: () => throw Exception("Service not found"));

  // returns the timestamp service
  BluetoothService timestampService = services.firstWhere(
      (element) => element.uuid.toString() == timestampServiceUUID,
      orElse: () => throw Exception("Service not found"));

  // returns the first characteristic of the service, which is the latitude
  BluetoothCharacteristic characteristicLat = service.characteristics.first;
  // returns the second characteristic of the service, which is the longitude
  BluetoothCharacteristic characteristicLng = service.characteristics.last;
  // returns the first characteristic of the timestamp service, which is the timestamp
  BluetoothCharacteristic characteristicTimestamp =
      timestampService.characteristics.first;

  // writes the latitude to the latitude characteristic
  await characteristicLat.write(latitude.codeUnits);
  // writes the longitude to the longitude characteristic
  await characteristicLng.write(longitude.codeUnits);

  // now write the current timestamp of the phone to the timestamp characteristic, in UTC format
  DateTime now = DateTime.now().toUtc();
  String timestamp = now.toString();
  // convert to the format YYYY-MM-DD, HH:mm:ss
  String firstPart = timestamp.substring(0, 10);
  String secondPart = timestamp.substring(11, 19);
  timestamp = firstPart + ", " + secondPart;

  await characteristicTimestamp.write(timestamp.codeUnits);
}
