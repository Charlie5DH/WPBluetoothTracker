// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions
// Imports custom functions

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<bool> connectDevice(BTDevicesStruct deviceInfo) async {
  final device = BluetoothDevice.fromId(deviceInfo.id);

  var hasWriteCharacteristic = false;

// Connect to the device
  try {
    print("-----------------------------------------------");
    print("Connecting to ${device.platformName}");
    await device.connect(
        timeout: const Duration(seconds: 25), autoConnect: true);
    print("-----------------------------------------------");
  } catch (e) {
    print("-----------Exception on connecting device-------------");
    print(e);
    print("-----------------------------------------------------");
  }

  // Check if the device is connected
  if (device.isConnected) {
    print("Connected to ${device.platformName}");
    final services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        final isWrite = characteristic.properties.write;
        if (isWrite) {
          debugPrint(
              'Found write characteristic: ${characteristic.uuid}, ${characteristic.properties}');
          hasWriteCharacteristic = true;
        }
      }
    }
  } else {
    print("Failed to connect to ${device.platformName}");
    // find the devices again and try to connect

    return false;
  }

  return hasWriteCharacteristic;
}
