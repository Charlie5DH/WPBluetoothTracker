// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future writeMotorAngle(
  BTDevicesStruct? deviceInfo,
  String? angle,
  String? characteristicUUID,
) async {
  // Add your function code here!
  // This action writes the angle to the service related to the motor
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
      (element) =>
          element.uuid.toString() == 'bf645b46-3d5b-4cdd-bbeb-d17d3a1fef4d',
      orElse: () => throw Exception("Characteristic not found"));

  // returns the characteristic with the given UUID
  // BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
  //     (element) => element.uuid.toString() == characteristicUUID,
  //     orElse: () => throw Exception("Characteristic not found"));

  print('----------------------------------------');
  print("write to characteristic: " + characteristic.uuid.toString());
  print("angle: " + angle!);
  print('----------------------------------------');

  // writes the angle to the characteristic
  await characteristic.write(angle.codeUnits);
}
