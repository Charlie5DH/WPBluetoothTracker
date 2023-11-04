// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<String> readFromCharacteristic(
  BTDevicesStruct? deviceInfo,
  String? serviceUUID,
  String? characteristicUUID,
) async {
  // Add your function code here!
  // This action serves to read from a characteristic
  // given a device, service and characteristic UUID
  final device = BluetoothDevice.fromId(deviceInfo!.id);
  final services = await device.discoverServices();

  // returns the service with the given UUID
  BluetoothService service = services.firstWhere(
      (element) => element.uuid.toString() == serviceUUID,
      orElse: () => throw Exception("Service not found"));

  // returns the characteristic with the given UUID
  BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
      (element) => element.uuid.toString() == characteristicUUID,
      orElse: () => throw Exception("Characteristic not found"));

  // reads the value from the characteristic
  List<int> value = await characteristic.read();

  String stringValue = String.fromCharCodes(value);
  // if the value has a |, add a space after and before the |
  if (stringValue.contains("|")) {
    stringValue = stringValue.replaceAll("|", " | ");
  }
  // remove the last character from the string
  stringValue = stringValue.substring(0, stringValue.length - 1);

  // returns the value as a string
  return stringValue;
}
