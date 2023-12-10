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

Future sendLanguageSetting(
    BTDevicesStruct? deviceInfo, String? language) async {
  if (language == null) {
    language = "POR";
  }

  final device = BluetoothDevice.fromId(deviceInfo!.id);
  final services = await device.discoverServices();

  String characteristicUUID = "5f33985d-9426-46d8-be68-f9b63880de67";

  // returns the service with the characteristic with the given UUID
  BluetoothService service = services.firstWhere(
      (element) =>
          element.characteristics.first.uuid.toString() == characteristicUUID,
      orElse: () => throw Exception("Service not found"));

  // returns the characteristic with the given UUID
  BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
      (element) =>
          element.uuid.toString() == '5f33985d-9426-46d8-be68-f9b63880de67',
      orElse: () => throw Exception("Characteristic not found"));

  // writes the language selected to the characteristic
  print('----------------------------------------');
  print("write to characteristic: " + characteristic.uuid.toString());
  print("language: " + language);
  print('----------------------------------------');

  await characteristic.write(language.codeUnits);
}
