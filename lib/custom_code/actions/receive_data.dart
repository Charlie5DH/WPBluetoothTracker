// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<String?> receiveData(BTDevicesStruct deviceInfo) async {
  final device = BluetoothDevice.fromId(deviceInfo.id);
  final services = await device.discoverServices();
  for (BluetoothService service in services) {
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      final isRead = characteristic.properties.read;
      final isNotify = characteristic.properties.notify;
      if (isRead && isNotify) {
        final value = await characteristic.read();
        return String.fromCharCodes(value);
      }
    }
  }
  return null;
}
