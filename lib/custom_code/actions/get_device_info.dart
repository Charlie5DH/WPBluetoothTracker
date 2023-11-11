// Automatic FlutterFlow imports
import 'dart:convert';

import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<String> getDeviceInfo(
  BTDevicesStruct? deviceInfo,
  String? serviceUUID,
) async {
  // Add your function code here!
  // This action reads from the service related to the line tatus
  // which has the UUID 6d98920a-905f-4c29-8322-b274154811ea
  // The service has 1 characteristics which is the line status
  // it returns the line status as a string

  final device = BluetoothDevice.fromId(deviceInfo!.id);
  final services = await device.discoverServices();

  // returns the service with the given UUID
  BluetoothService service = services.firstWhere(
      (element) => element.uuid.toString() == serviceUUID,
      orElse: () => throw Exception("Service not found"));

  // returns the characteristic of the service
  BluetoothCharacteristic characteristic = service.characteristics.first;

  // reads the value from the characteristic
  List<int> value = await characteristic.read();
  // decode the value to a string in UTF-8

  //String stringValue = String.fromCharCodes(value);
  // convert the String to UTF-8
  String stringValue = utf8.decode(value);
  // remove the last character from the string
  stringValue = stringValue.substring(0, stringValue.length - 1);

  if (stringValue.contains("|")) {
    stringValue = stringValue.replaceAll("|", " | ");
  }

  return stringValue;
}
