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

Future disconnectDevice(BTDevicesStruct deviceInfo) async {
  BluetoothDevice device = BluetoothDevice.fromId(deviceInfo.id);
  try {
    await device.disconnect();
  } catch (e) {
    print(e);
  }
}
