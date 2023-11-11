// Automatic FlutterFlow imports
import 'dart:convert';

import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<String> readMotorAngle(
  BTDevicesStruct? deviceInfo,
  String? characteristicUUID,
) async {
  // Add your function code here!
  // This action reads the angle from the service related to the motor
  // The service has 1 characteristics with the UUID b5b10c03-7f57-43bb-8451-5af4767a4459

  final device = BluetoothDevice.fromId(deviceInfo!.id);
  final services = await device.discoverServices();

  // returns the service with the characteristic with the given UUID
  BluetoothService service = services.firstWhere(
      (element) =>
          element.characteristics.first.uuid.toString() == characteristicUUID,
      orElse: () => throw Exception("Service not found"));

  // returns the characteristic with the given UUID
  BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
      (element) => element.uuid.toString() == characteristicUUID,
      orElse: () => throw Exception("Characteristic not found"));

  // reads the value from the characteristic
  List<int> value = await characteristic.read();

  // String stringValue = String.fromCharCodes(value);
  // convert the String to UTF-8
  String stringValue = utf8.decode(value);

  // remove the last character from the string if is not a number or a degree symbol
  if (stringValue.substring(stringValue.length - 1) != "0" &&
      stringValue.substring(stringValue.length - 1) != "1" &&
      stringValue.substring(stringValue.length - 1) != "2" &&
      stringValue.substring(stringValue.length - 1) != "3" &&
      stringValue.substring(stringValue.length - 1) != "4" &&
      stringValue.substring(stringValue.length - 1) != "5" &&
      stringValue.substring(stringValue.length - 1) != "6" &&
      stringValue.substring(stringValue.length - 1) != "7" &&
      stringValue.substring(stringValue.length - 1) != "8" &&
      stringValue.substring(stringValue.length - 1) != "9" &&
      stringValue.substring(stringValue.length - 1) != "°") {
    stringValue = stringValue.substring(0, stringValue.length - 1);
  }

  // and remove everything before the |, if there is a | character
  if (stringValue.contains("|")) {
    stringValue = stringValue.substring(stringValue.indexOf("|") + 1);
  }

  // returns the angle as a string
  return stringValue;
}
