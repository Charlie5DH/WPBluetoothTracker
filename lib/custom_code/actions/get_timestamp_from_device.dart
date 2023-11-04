// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<String> getTimestampFromDevice(
    BTDevicesStruct? deviceInfo, String? serviceUUID) async {
  // Add your function code here!
  // This action reads from the service related to the timestamp
  // which has the UUID a617811d-d2a0-4155-923e-de09de01849c
  // The service has 1 characteristic which is the timestamp
  // This action returns the timestamp as a string

  if (serviceUUID == null) {
    serviceUUID = "a617811d-d2a0-4155-923e-de09de01849c";
  }

  final device = BluetoothDevice.fromId(deviceInfo!.id);
  final services = await device.discoverServices();

  // returns the service with the given UUID

  BluetoothService service = services.firstWhere(
      (element) => element.uuid.toString() == serviceUUID,
      orElse: () => throw Exception("Service not found"));

  // returns the first characteristic of the service, which is the timestamp
  BluetoothCharacteristic characteristic = service.characteristics.first;

  // reads the value from the characteristic
  List<int> value = await characteristic.read();

  String stringValue = String.fromCharCodes(value);
  // if the value has a |, take the part after the |, otherwise take the whole string
  if (stringValue.contains("|")) {
    stringValue = stringValue.substring(stringValue.indexOf("|") + 1);
  }
  // remove the last character from the string
  stringValue = stringValue.substring(0, stringValue.length - 1);

  // returns the value as a string
  return stringValue;
}
