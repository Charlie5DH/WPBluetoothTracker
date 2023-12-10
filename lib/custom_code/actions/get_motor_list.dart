// Automatic FlutterFlow imports
import 'dart:convert';

import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<List<String>> getMotorList(
  BTDevicesStruct? deviceInfo,
  String? characteristicUUID,
) async {
  // Add your function code here!
  // This action reads the angle from the service related to the motor
  // The service has 1 characteristics with the UUID b5b10c03-7f57-43bb-8451-5af4767a4459

  List<String> motorList = [];

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

  // reads the value from the characteristic until found the "END" string

  String accumulatedValue = '';
  bool endFound = false;
  int iterationCount = 0;
  int maxIterations = 5;

  while (!endFound && iterationCount < maxIterations) {
    // waits 100ms before reading again
    await Future.delayed(Duration(milliseconds: 100));
    List<int> value = await characteristic.read();
    String receivedString = utf8.decode(value);
    // remove last character
    receivedString = receivedString.substring(0, receivedString.length - 1);

    // check if received string is equal to the previous one
    // if so, it means that the value is not changing anymore
    // so it is the last value
    if (receivedString == accumulatedValue) {
      endFound = true;
      print('END found, final accumulated value: $accumulatedValue');
      break;
    }

    accumulatedValue += receivedString;

    iterationCount = iterationCount + 1;

    print('Received: $receivedString');
    print('Accumulated: $accumulatedValue');

    if (accumulatedValue.contains("END")) {
      endFound = true;
      accumulatedValue = accumulatedValue.substring(
        0,
        accumulatedValue.indexOf("END"),
      );
      print('END found, final accumulated value: $accumulatedValue');
    }
  }

  print(accumulatedValue);
  motorList = accumulatedValue.split("\n");
  print('Final Motor List: $motorList');
  // check if the last value is empty
  if (motorList.last == "" || motorList.last == "\n" || motorList.last == " ") {
    motorList.removeLast();
  }

  return motorList;
}
